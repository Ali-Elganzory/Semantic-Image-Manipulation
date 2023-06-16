import yaml
import torch
import numpy as np
import cv2
import logging
import os
import shutil
from typing import *
from omegaconf import OmegaConf
from torch.utils.data._utils.collate import default_collate

from backend.ml.Inpainter.saicinpainting.training.trainers import load_checkpoint
from backend.ml.Inpainter.saicinpainting.training.data.datasets import (
    make_default_val_dataset,
)
from backend.ml.Inpainter.saicinpainting.evaluation.utils import move_to_device


os.environ["OMP_NUM_THREADS"] = "1"
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["MKL_NUM_THREADS"] = "1"
os.environ["VECLIB_MAXIMUM_THREADS"] = "1"
os.environ["NUMEXPR_NUM_THREADS"] = "1"

LOGGER = logging.getLogger(__name__)


class Inpainter:
    def __init__(self, predict_config_path: str):
        # Config
        self.predict_config_path = predict_config_path
        with open(self.predict_config_path, "r") as f:
            self.predict_config = OmegaConf.create(yaml.safe_load(f))

        train_config_path = os.path.join(self.predict_config.model.path, "config.yaml")
        with open(train_config_path, "r") as f:
            self.train_config = OmegaConf.create(yaml.safe_load(f))
        self.train_config.training_model.predict_only = True
        self.train_config.visualizer.kind = "noop"

        self.device = torch.device(self.predict_config.device)
        self.out_ext = self.predict_config.get("out_ext", ".jpg")
        if not self.predict_config.indir.endswith("/"):
            self.predict_config.indir += "/"

        self.checkpoint_path = os.path.join(
            self.predict_config.model.path,
            "models",
            self.predict_config.model.checkpoint,
        )

        # Load the model
        self.model = load_checkpoint(
            self.train_config, self.checkpoint_path, strict=False, map_location="cpu"
        )
        self.model.freeze()
        self.model.to(self.device)

    def inpaint(
        self,
        img_path: Union[str, List[str]],
        mask_path: Union[str, List[str]],
        out_path: Union[str, List[str]],
    ) -> bool:
        try:
            # Prepare paths
            image_paths = [img_path] if isinstance(img_path, str) else img_path
            mask_paths = [mask_path] if isinstance(mask_path, str) else mask_path
            out_paths = [out_path] if isinstance(out_path, str) else out_path
            assert len(image_paths) == len(mask_paths) == len(out_paths)

            # Map image and mask paths to dataset naming scheme
            image_symlink_paths = [
                os.path.join(
                    self.predict_config.indir, f"image{i + 1}" + os.path.splitext(p)[1]
                )
                for i, p in enumerate(image_paths)
            ]
            mask_symlink_paths = [
                os.path.join(
                    self.predict_config.indir,
                    f"image{i + 1}_mask001" + os.path.splitext(p)[1],
                )
                for i, p in enumerate(mask_paths)
            ]

            # Prepare dataset folder
            dataset_folder = self.predict_config.indir
            os.makedirs(dataset_folder, exist_ok=True)
            for image_path, mask_path, image_symlink_path, mask_symlink_path in zip(
                image_paths, mask_paths, image_symlink_paths, mask_symlink_paths
            ):
                # todo: create symlink instead of copying
                shutil.copy(image_path, image_symlink_path)
                shutil.copy(mask_path, mask_symlink_path)

            dataset = make_default_val_dataset(
                self.predict_config.indir, **self.predict_config.dataset
            )

            # Predict
            with torch.no_grad():
                for img_i in range(len(dataset)):
                    print(img_i)
                    mask_fname = dataset.mask_filenames[img_i]
                    cur_out_fname = os.path.join(
                        self.predict_config.outdir,
                        os.path.splitext(mask_fname[len(self.predict_config.indir) :])[
                            0
                        ]
                        + self.out_ext,
                    )
                    os.makedirs(os.path.dirname(cur_out_fname), exist_ok=True)

                    batch = move_to_device(
                        default_collate([dataset[img_i]]), self.device
                    )
                    batch["mask"] = (batch["mask"] > 0) * 1
                    batch = self.model(batch)
                    cur_res = (
                        batch[self.predict_config.out_key][0]
                        .permute(1, 2, 0)
                        .detach()
                        .cpu()
                        .numpy()
                    )

                    unpad_to_size = batch.get("unpad_to_size", None)
                    if unpad_to_size is not None:
                        orig_height, orig_width = unpad_to_size
                        cur_res = cur_res[:orig_height, :orig_width]

                    cur_res = np.clip(cur_res * 255, 0, 255).astype("uint8")
                    cur_res = cv2.cvtColor(cur_res, cv2.COLOR_RGB2BGR)
                    cv2.imwrite(out_paths[img_i], cur_res)

        except Exception as e:
            raise e

        # Remove symlinks
        for image_symlink_path, mask_symlink_path in zip(
            image_symlink_paths, mask_symlink_paths
        ):
            os.remove(image_symlink_path)
            os.remove(mask_symlink_path)

        return True
