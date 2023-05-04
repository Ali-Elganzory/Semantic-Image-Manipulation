from flask import (
    Blueprint, Flask, request
)
from sqlalchemy import func

from backend.database import db_session
from backend.models import Detection, Label, Task, TaskStatus, TaskType
from backend.tasks import detect as detection_task

bp = Blueprint('detections', __name__, url_prefix='/detections')


@bp.get('/labels')
def labels():
    labels = db_session.query(Label).all()

    return {
        'message': '',
        'data': labels,
    }


@bp.post('/')
def detect():
    image_id = request.json['image_id']
    label_ids = request.json['label_ids']

    task = Task(
        image_id=image_id,
        type=TaskType.DETECTION,
        status=TaskStatus.PENDING,
        progress=0,
    ).save()

    detection_task.delay(
        task.id,
        label_ids,
    )

    return {
        'message': '',
        'data': task,
    }


@bp.get('/image/<int:image_id>')
def image_detections(image_id: int):
    detections = db_session.query(Detection).filter(
        Detection.image_id == image_id,
    ).all()

    return {
        'message': '',
        'data': [
            {
                **detection.asdict(),
                'label': detection.label.name,
            } for detection in detections
        ],
    }


@bp.get('/task/<string:task_id>')
def task_detections(task_id: str):
    detections = db_session.query(Detection).filter(
        Detection.task_id == task_id,
    ).all()

    return {
        'message': '',
        'data': [
            {
                **detection.asdict(),
                'label': detection.label.name,
            } for detection in detections
        ],
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
