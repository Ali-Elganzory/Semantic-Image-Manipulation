import torch
from pathlib import Path
from PIL import Image, ImageOps
from diffusers import (
    StableDiffusionInstructPix2PixPipeline,
    EulerAncestralDiscreteScheduler,
)
import accelerate


class Editor:
    def __init__(self):
        self.pipe = None

    def __initialize_pipeline(self):
        self.model_id = "timbrooks/instruct-pix2pix"
        self.pipe = StableDiffusionInstructPix2PixPipeline.from_pretrained(
            self.model_id,
            torch_dtype=torch.float16,
            safety_checker=None,
            cache_dir=Path(__file__).parent.joinpath("models"),
        )
        self.pipe.to("cuda")
        self.pipe.scheduler = EulerAncestralDiscreteScheduler.from_config(
            self.pipe.scheduler.config
        )

    def edit(self, image_path: str, prompt: str) -> Image:
        if self.pipe is None:
            self.__initialize_pipeline()

        image = Image.open(image_path)
        image = ImageOps.exif_transpose(image)
        image = image.convert("RGB")
        images = self.pipe(
            prompt, image=image, num_inference_steps=10, image_guidance_scale=1
        ).images

        return images[0]
