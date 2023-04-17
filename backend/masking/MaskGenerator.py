from typing import Iterable
import cv2 as cv
import numpy as np

from ml.yolo.YOLO import BBox


class MaskGenerator:
    def __init__(self, clearance_ratio: float = 0.1):
        assert clearance_ratio >= 0 and clearance_ratio <= 1
        self.clearance_ratio = clearance_ratio

    def generate(self, image: np.ndarray, bboxes: Iterable[BBox]):
        mask = np.zeros(image.shape[:2], dtype=np.uint8)
        for bbox in bboxes:
            temp_mask = np.zeros(image.shape[:2], dtype=np.uint8)
            background_model = np.zeros((1, 65), np.float64)
            foreground_model = np.zeros((1, 65), np.float64)
            cv.grabCut(image,
                       temp_mask,
                       bbox.scaled(1 + self.clearance_ratio).xywh,
                       background_model,
                       foreground_model,
                       5,
                       cv.GC_INIT_WITH_RECT)
            mask = np.where((temp_mask == cv.GC_FGD)
                            | (temp_mask == cv.GC_PR_FGD)
                            | (mask != 0),
                            255, 0).astype(np.uint8)
        return mask
