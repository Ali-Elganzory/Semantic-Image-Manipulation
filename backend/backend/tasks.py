from typing import List
from celery import shared_task
import cv2

from backend.celery_app import FlaskTask
from backend.database import db_session
from backend.ml.yolo.YOLO import BBox
from backend.models import (
    Detection, Image, Task, TaskType, TaskStatus
)


@shared_task(bind=True)
def detect(
    self: FlaskTask,
    task_id: int,
    label_ids: List[int],
) -> None:
    task = Task().get(task_id)
    task.status = TaskStatus.RUNNING
    task.update()

    def failed():
        task.status = TaskStatus.ERROR
        task.save()

    def success():
        task.status = TaskStatus.SUCCESS
        task.update()

    try:
        image = Image().get(task.image_id)
        if image is None:
            failed()
            return

        image_file = cv2.imread(image.path)
        if image_file is None:
            failed()
            return

        result: List[BBox] = self.detection_model.detect(
            image_file,
            label_ids,
        )
        for detection in result:
            Detection(
                image_id=task.image_id,
                label_id=detection.label_id,
                task_id=task.id,
                confidence=detection.confidence,
                x=detection.x1,
                y=detection.y1,
                w=detection.width,
                h=detection.height,
            ).save()

        success()

    except Exception:
        failed()
        raise
