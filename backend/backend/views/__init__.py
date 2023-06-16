from flask import Flask


def init_app(app: Flask):
    from . import images, tasks, detection, editing

    for view in [images, tasks, detection, editing]:
        view.init_app(app)
