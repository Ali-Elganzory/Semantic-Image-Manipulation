from flask import Flask


def init_app(app: Flask):
    from . import images, tasks, detection, inpainting, editing

    for view in [images, tasks, detection, inpainting, editing]:
        view.init_app(app)
