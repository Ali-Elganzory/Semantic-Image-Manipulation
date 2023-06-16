from typing import Iterable
import cv2 as cv
import numpy as np

from backend.ml.yolo.YOLO import BBox


class MaskGenerator:
    def __init__(self, clearance_ratio: float = 0.1, smooth_kernel_size: int = 50):
        assert clearance_ratio >= 0 and clearance_ratio <= 1
        self.clearance_ratio = clearance_ratio
        self.smooth_kernel_size = smooth_kernel_size

    def generate(self, image: np.ndarray, bboxes: Iterable[BBox]):
        mask = np.zeros(image.shape[:2], dtype=np.uint8)
        for bbox in bboxes:
            temp_mask = np.zeros(image.shape[:2], dtype=np.uint8)
            background_model = np.zeros((1, 65), np.float64)
            foreground_model = np.zeros((1, 65), np.float64)
            cv.grabCut(
                image,
                temp_mask,
                bbox.scaled(1 + self.clearance_ratio).xywh,
                background_model,
                foreground_model,
                5,
                cv.GC_INIT_WITH_RECT,
            )
            mask = np.where(
                (temp_mask == cv.GC_FGD) | (temp_mask == cv.GC_PR_FGD) | (mask != 0),
                255,
                0,
            ).astype(np.uint8)

        if self.smooth_kernel_size != 0:
            kernel = np.full(
                (self.smooth_kernel_size, self.smooth_kernel_size), 255, np.float32
            ) / (self.smooth_kernel_size**2)
            mask = cv.filter2D(src=mask, ddepth=-1, kernel=kernel)
            mask = np.where(mask > 0, 255, 0).astype("uint8")

        return mask
