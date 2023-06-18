from flask import Blueprint, Flask

from backend.models import Task
from backend.database import db_session

bp = Blueprint("tasks", __name__, url_prefix="/tasks")


@bp.get("/<int:task_id>")
def get_task(task_id: int):
    task = Task().get(task_id)

    if task is None:
        return {
            "message": "Task not found.",
            "data": {},
        }, 404

    return {
        "message": "",
        "data": task,
    }


@bp.get("/image/<int:image_id>")
def get_image_tasks(image_id: int):
    tasks = Task.of_image(image_id)

    return {
        "message": "",
        "data": tasks,
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
