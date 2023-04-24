from flask import Flask
from celery import Celery, Task

from backend import create_app


def init_app(app: Flask) -> Celery:
    global FlaskTask

    class FlaskTask(Task):
        def __init__(self, *args: object, **kwargs: object) -> None:
            super().__init__(*args, **kwargs)
            self.detection_model = None

        def __call__(self, *args: object, **kwargs: object) -> object:
            # Initialize detection model only once
            if self.detection_model is None:
                from backend.ml.yolo.YOLO import YOLO
                self.detection_model = YOLO()

            with app.app_context():
                return self.run(*args, **kwargs)

    celery_app = Celery(app.name)
    celery_app.config_from_object(app.config["CELERY"])
    celery_app.Task = FlaskTask
    celery_app.set_default()
    app.extensions["celery"] = celery_app
    return celery_app


flask_app = create_app()
celery_app = flask_app.extensions["celery"]
