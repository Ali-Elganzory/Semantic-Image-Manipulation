from flask import Blueprint, Flask, request, url_for

from backend.models import Task, TaskStatus, TaskType, ModifiedImage
from backend.tasks import inpaint as inpainting_task

bp = Blueprint("inpainting", __name__, url_prefix="/inpainting")


@bp.post("/")
def inpaint():
    image_id = request.json["image_id"]
    detection_ids = request.json["detection_ids"]
    extreme_mode = request.json["extreme_mode"]

    task = Task(
        image_id=image_id,
        type=TaskType.INPAINTING,
        status=TaskStatus.PENDING,
        progress=0,
    ).save()

    inpainting_task.delay(
        task.id,
        detection_ids,
        extreme_mode if extreme_mode is not None else False,
    )

    return {
        "message": "",
        "data": task,
    }


@bp.get("/image/<int:image_id>")
def image_inpaints(image_id: int):
    modified_images = ModifiedImage.inpaints_of_image(image_id)

    return {
        "message": "",
        "data": [
            {
                "id": modified_image.id,
                "url": url_for(
                    "images.download_modified_image",
                    image_filename=modified_image.path.split("/")[-1],
                    _external=True,
                ),
            }
            for modified_image in modified_images
        ],
    }


@bp.get("/task/<string:task_id>")
def task_inpaint(task_id: str):
    modified_image = ModifiedImage.of_task(task_id)

    return {
        "message": "",
        "data": {
            "id": modified_image.id,
            "url": url_for(
                "images.download_modified_image",
                image_filename=modified_image.path.split("/")[-1],
                _external=True,
            ),
        },
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
