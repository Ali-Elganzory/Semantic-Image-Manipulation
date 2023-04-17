from __future__ import annotations
import numpy as np
from pathlib import Path
from dataclasses import dataclass
from typing import Iterable, List, Tuple, Union
from ultralytics import YOLO as YOLOUltra
from ultralytics.yolo.engine.results import Results

from shared.math import scaled


class ModelSize:
    XLarge = 'yolov8x'


@dataclass
class BBox:
    x1: int
    y1: int
    x2: int
    y2: int
    confidence: int
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
        return BBox(*scaled(self.xyxy, scale),
                    self.confidence,
                    self.label)


class YOLO:
    def __init__(self, model_size: str = ModelSize.XLarge):
        self.model_size = model_size
        self.path = Path(__file__).parent
        self.detection_model = YOLOUltra(
            model=f"{self.path}/detect_{self.model_size}.pt")
        self.segmentation_model = YOLOUltra(
            model=f"{self.path}/segment_{self.model_size}.pt")
        self.class_names = self.detection_model.names

    @ property
    def labels(self):
        return [*self.class_names]

    def detect(self, images: Union[List[np.ndarray], np.ndarray], classes: str = None) -> Union[List[BBox], BBox]:
        if isinstance(images, np.ndarray):
            images = [images]
        results: Iterable[Results] = map(
            lambda x: x.numpy(), self.detection_model(images))
        bounding_boxes = [[BBox(*map(lambda x: int(x), result.boxes.xyxy[i]),
                                result.boxes.conf[i],
                                self.class_names[int(result.boxes.cls[i])])]
                          for result in results for i in range(len(result.boxes))]
        if classes:
            bounding_boxes = [[box for box in boxes if box.label in classes]
                              for boxes in bounding_boxes]
        return bounding_boxes[0] if len(bounding_boxes) == 1 else bounding_boxes

    def segment(self, image: np.ndarray):
        pass
