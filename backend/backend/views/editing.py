from flask import Blueprint, Flask, request, url_for

from backend.models import Task, TaskStatus, TaskType, Prompt, ModifiedImage
from backend.tasks import edit as editing_task

bp = Blueprint("editing", __name__, url_prefix="/editing")


@bp.post("/")
def edit():
    image_id = request.json["image_id"]
    prompt = request.json["prompt"]

    task = Task(
        image_id=image_id,
        type=TaskType.EDITING,
        status=TaskStatus.PENDING,
        progress=0,
    ).save()

    prompt = Prompt(
        task_id=task.id,
        text=prompt,
    ).save()

    editing_task.delay(
        task.id,
    )

    return {
        "message": "",
        "data": {"task": task, "prompt": prompt},
    }


@bp.get("/image/<int:image_id>")
def image_edits(image_id: int):
    modified_images = ModifiedImage.of_image(image_id)

    return {
        "message": "",
        "data": [
            {
                "id": modified_image.id,
                "prompt": Prompt.of_task(modified_image.task_id).text,
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
def task_edit(task_id: str):
    modified_image = ModifiedImage.of_task(task_id)
    prompt = Prompt.of_task(modified_image.task_id).text

    return {
        "message": "",
        "data": {
            "id": modified_image.id,
            "prompt": prompt,
            "url": url_for(
                "images.download_modified_image",
                image_filename=modified_image.path.split("/")[-1],
                _external=True,
            ),
        },
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
