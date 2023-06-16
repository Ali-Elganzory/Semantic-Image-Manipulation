import os

from flask import Flask
from flask_cors import CORS


def create_app(test_config=None):
    # Create the app
    app = Flask(__name__, instance_relative_config=True)

    # Configuration
    CORS(app)
    app.config.from_mapping(
        SECRET_KEY="dev",
        DATABASE=os.path.join(app.instance_path, "database.sqlite"),
        UPLOAD_FOLDER=os.path.join(app.instance_path, "uploads"),
        MODIFIED_FOLDER=os.path.join(app.instance_path, "modified"),
        MASKS_FOLDER=os.path.join(app.instance_path, "masks"),
        CELERY=dict(
            broker_url="redis://redis",
            result_backend="redis://redis",
            task_ignore_result=True,
        ),
    )

    if test_config is None:
        # Load the instance config, if it exists, when not testing
        app.config.from_pyfile("config.py", silent=True)
    else:
        # Load the test config if passed in
        app.config.from_mapping(test_config)

    # Ensure the instance folders exists
    try:
        folders = [
            app.instance_path,
            app.config["UPLOAD_FOLDER"],
            app.config["MODIFIED_FOLDER"],
            app.config["MASKS_FOLDER"],
        ]
        for folder in folders:
            os.makedirs(folder, exist_ok=True)
    except OSError:
        pass

    # Initialize services
    from . import celery_app, database, commands, views

    for service in [celery_app, database, commands, views]:
        service.init_app(app)

    return app
