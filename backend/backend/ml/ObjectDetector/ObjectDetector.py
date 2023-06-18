from __future__ import annotations
import numpy as np
from pathlib import Path
from dataclasses import dataclass
from typing import Iterable, List, Tuple, Union
from ultralytics import YOLO as YOLOUltra
from ultralytics.yolo.engine.results import Results


class ModelSize:
    XLarge = "yolov8x"


@dataclass
class BBox:
    x1: int
    y1: int
    x2: int
    y2: int
    confidence: float
    label_id: int
    label: str

    @property
    def left(self) -> int:
        return self.x1

    @property
    def top(self) -> int:
        return self.y1

    @property
    def right(self) -> int:
        return self.x2

    @property
    def bottom(self) -> int:
        return self.y2

    @property
    def width(self) -> int:
        return self.x2 - self.x1

    @property
    def height(self) -> int:
        return self.y2 - self.y1

    @property
    def xyxy(self) -> Tuple[int, int, int, int]:
        return self.x1, self.y1, self.x2, self.y2

    @property
    def xywh(self) -> Tuple[int, int, int, int]:
        return self.x1, self.y1, self.x2 - self.x1, self.y2 - self.y1

    def scaled(self, scale: float) -> BBox:
        return BBox(
            *scaled(self.xyxy, scale),
            self.confidence,
            self.label_id,
            self.label,
        )


class ObjectDetector:
    def __init__(self, model_size: str = ModelSize.XLarge):
        self.model_size = model_size
        self.path = Path(__file__).parent
        self.detection_model = YOLOUltra(
            model=f"{self.path}/detect_{self.model_size}.pt"
        )
        # self.segmentation_model = YOLOUltra(
        #     model=f"{self.path}/segment_{self.model_size}.pt")
        self.class_names = self.detection_model.names

    @property
    def labels(self):
        return [*self.class_names]

    def detect(
        self,
        images: Union[List[np.ndarray], np.ndarray],
        label_ids: List[int] = [],
    ) -> Union[List[List[BBox]], List[BBox]]:
        if isinstance(images, np.ndarray):
            images = [images]

        results: Iterable[Results] = map(
            lambda x: x.cpu().numpy(), self.detection_model(images)
        )
        bounding_boxes = [
            [
                BBox(
                    *map(lambda x: int(x), result.boxes.xyxy[i]),
                    result.boxes.conf[i],
                    int(result.boxes.cls[i]),
                    self.class_names[int(result.boxes.cls[i])],
                )
                for i in range(len(result.boxes))
            ]
            for result in results
        ]

        if len(label_ids) > 0:
            bounding_boxes = [
                [box for box in boxes if box.label_id in label_ids]
                for boxes in bounding_boxes
            ]

        return bounding_boxes[0] if len(bounding_boxes) == 1 else bounding_boxes


def scaled(
    coordinates: Tuple[int, int, int, int], scale: float
) -> Tuple[int, int, int, int]:
    coordinates = np.array(coordinates, dtype=np.float32)
    translation = np.array(
        [
            (coordinates[0] + coordinates[2]) / 2,
            (coordinates[1] + coordinates[3]) / 2,
            (coordinates[0] + coordinates[2]) / 2,
            (coordinates[1] + coordinates[3]) / 2,
        ]
    )
    coordinates -= translation
    coordinates *= scale
    coordinates += translation
    return tuple(map(lambda x: int(x), coordinates))
