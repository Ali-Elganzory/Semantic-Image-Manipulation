from flask import Flask


def init_app(app: Flask):
    from . import images
    app.register_blueprint(images.bp)

    from . import detection
    app.register_blueprint(detection.bp)

    from . import tasks
    app.register_blueprint(tasks.bp)
