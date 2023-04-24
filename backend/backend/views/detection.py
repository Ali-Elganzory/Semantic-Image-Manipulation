from flask import (
    Blueprint, Flask, request
)
from sqlalchemy import func

from backend.database import db_session
from backend.models import Detection, Label
from backend.tasks import detect as detection_task

bp = Blueprint('detection', __name__, url_prefix='/detection')


@bp.get('/labels')
def labels():
    labels = db_session.query(Label).all()

    return {
        'message': '',
        'data': labels,
    }


@bp.post('/')
def detect():
    result = detection_task.delay(
        request.json['image_id'],
    )

    return {
        'message': '',
        'data': {
            'task_id': result.id,
        },
    }


@bp.get('/detections/image/<int:image_id>')
def detections_by_image(image_id: int):
    detections = db_session.query(Detection).filter(
        Detection.image_id == image_id,
    ).all()

    return {
        'message': '',
        'data': detections,
    }


@bp.get('/detections/task/<string:task_id>')
def detections_by_task(task_id: str):
    detections = db_session.query(Detection).filter(
        Detection.task_id == task_id,
    ).all()

    return {
        'message': '',
        'data': detections,
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
