from typing import Iterable
import numpy as np
import cv2 as cv

from ml.yolo.YOLO import BBox


class BBoxesPainter(object):
    def __init__(self, color=(255, 178, 50), thickness=3):
        self.color = color
        self.thickness = thickness

    def paint(self, image: np.ndarray, bboxes: Iterable[BBox]):
        for bbox in bboxes:
            cv.rectangle(image, (bbox.x1, bbox.y1),
                         (bbox.x2, bbox.y2), self.color, self.thickness)
            label = '%s: %.2f' % (bbox.label, bbox.confidence)
            labelSize, baseLine = cv.getTextSize(
                label, cv.FONT_HERSHEY_SIMPLEX, 0.5, 1)
            top = max(bbox.y1, labelSize[1])
            cv.rectangle(image, (bbox.x1, bbox.y1 - round(1.5*labelSize[1])), (bbox.x1 + round(
                1.5*labelSize[0]), top + baseLine), (255, 255, 255), cv.FILLED)
            image = cv.putText(image, label, (bbox.x1 + round(0.25*labelSize[0]), top - round(0.25*labelSize[1])),
                               cv.FONT_HERSHEY_SIMPLEX, 0.5, self.color, 1, cv.LINE_AA)
        return image
