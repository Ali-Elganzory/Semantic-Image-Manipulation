from typing import List, Callable
from celery import shared_task
from PIL import Image as PILImage
import cv2

from backend.celery_app import FlaskTask
from backend.ml.yolo.YOLO import BBox
from backend.models import Detection, Image, Task, TaskStatus, Prompt, ModifiedImage


class HandlerException(Exception):
    pass


@shared_task(bind=True)
def detect(
    self: FlaskTask,
    task_id: int,
    label_ids: List[int],
) -> None:
    task = Task().get(task_id)

    def handler():
        image = Image().get(task.image_id)
        if image is None:
            raise HandlerException()

        image_file = cv2.imread(image.path)
        if image_file is None:
            raise HandlerException()

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

    handle_task(task, handler)


@shared_task(bind=True)
def inpaint(
    self: FlaskTask,
    task_id: int,
    detection_ids: List[int],
) -> None:
    task = Task().get(task_id)

    def handler():
        # Get input image
        image = Image().get(task.image_id)

        if image is None:
            raise HandlerException()

        image_file = cv2.imread(image.path)
        if image_file is None:
            raise HandlerException()

        # Create bounding boxes
        detections: List[Detection] = Detection().all(detection_ids)
        bboxs = map(
            lambda detection: BBox(
                detection.x,
                detection.y,
                detection.x + detection.w,
                detection.y + detection.h,
                detection.confidence,
                detection.label_id,
                detection.label,
            ),
            detections,
        )

        # Generate mask
        mask = self.mask_generator.generate(image_file, bboxs)
        mask_path = self.generate_mask_path("jpg")
        cv2.imwrite(mask_path, mask)

        # Generate modified image path
        output_image_path = self.generate_modified_path("jpg")

        # Inpaint
        self.inpainting_model.inpaint(image.path, mask_path, output_image_path)

        # Save modified image
        ModifiedImage(
            image_id=task.image_id,
            task_id=task.id,
            path=output_image_path,
        ).save()

    handle_task(task, handler)


@shared_task(bind=True)
def edit(
    self: FlaskTask,
    task_id: int,
) -> None:
    task = Task().get(task_id)

    def handler():
        image: Image = Image().get(task.image_id)
        prompt = Prompt.of_task(task_id)

        if image is None or prompt is None:
            raise HandlerException()

        result: PILImage.Image = self.editing_model.edit(
            image.path,
            prompt.text,
        )

        extension = image.path.split(".")[-1]
        modified_path = self.generate_modified_path(extension)

        result.save(modified_path)

        ModifiedImage(
            image_id=task.image_id,
            task_id=task.id,
            path=modified_path,
        ).save()

    handle_task(task, handler)


def handle_task(
    task: Task,
    handler: Callable[[], None],
) -> None:
    task.status = TaskStatus.RUNNING
    task.update()

    def failed():
        task.status = TaskStatus.ERROR
        task.save()

    def success():
        task.status = TaskStatus.SUCCESS
        task.update()

    try:
        handler()
        success()

    except HandlerException:
        failed()

    except Exception:
        failed()
        raise
