from typing import Tuple

import numpy as np


def scaled(coordinates: Tuple[int, int, int, int], scale: float) -> Tuple[int, int, int, int]:
    coordinates = np.array(coordinates, dtype=np.float32)
    translation = np.array([(coordinates[0] + coordinates[2]) / 2,
                            (coordinates[1] + coordinates[3]) / 2,
                            (coordinates[0] + coordinates[2]) / 2,
                            (coordinates[1] + coordinates[3]) / 2])
    coordinates -= translation
    coordinates *= scale
    coordinates += translation
    return tuple(map(lambda x: int(x), coordinates))
