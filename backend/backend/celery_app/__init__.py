from flask import Flask
from celery import Celery, Task
import os
import uuid
from pathlib import Path

from backend import create_app


def init_app(app: Flask) -> Celery:
    global FlaskTask

    class FlaskTask(Task):
        def __init__(self, *args: object, **kwargs: object) -> None:
            super().__init__(*args, **kwargs)
            self.detection_model = None
            self.editing_model = None
            self.mask_generator = None
            self.inpainting_model = None

            self.modified_folder = app.config["MODIFIED_FOLDER"]
            self.masks_folder = app.config["MASKS_FOLDER"]

        def __call__(self, *args: object, **kwargs: object) -> object:
            # Initialize detection model only once
            if self.detection_model is None:
                from backend.ml.yolo.YOLO import YOLO

                self.detection_model = YOLO()

            # Initialize edit model only once
            if self.editing_model is None:
                from backend.ml.Editor.Editor import Editor

                self.editing_model = Editor()

            # Initialize mask generator only once
            if self.mask_generator is None:
                from backend.masking.MaskGenerator import MaskGenerator

                self.mask_generator = MaskGenerator()

            # Initialize inpainting model only once
            if self.inpainting_model is None:
                from backend.ml.Inpainter.Inpainter import Inpainter

                self.inpainting_model = Inpainter(
                    Path(__file__).parent.joinpath("../ml/Inpainter/default.yaml")
                )

            with app.app_context():
                return self.run(*args, **kwargs)

        def generate_modified_path(self, ext: str) -> str:
            return os.path.join(
                self.modified_folder,
                str(uuid.uuid4()) + ("." + ext if ext else ""),
            )

        def generate_mask_path(self, ext: str) -> str:
            return os.path.join(
                self.masks_folder,
                str(uuid.uuid4()) + ("." + ext if ext else ""),
            )

    celery_app = Celery(app.name)
    celery_app.config_from_object(app.config["CELERY"])
    celery_app.Task = FlaskTask
    celery_app.set_default()
    app.extensions["celery"] = celery_app
    return celery_app


flask_app = create_app()
celery_app = flask_app.extensions["celery"]
