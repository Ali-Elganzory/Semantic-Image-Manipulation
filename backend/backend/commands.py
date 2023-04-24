import json
import click
from flask import Flask, current_app
from flask.cli import with_appcontext

from backend.database import db_session


@click.command('update-labels')
@with_appcontext
def update_labels():
    """
    Update the detection labels in the database.

    Removes all existing labels and adds the labels
    that are currently used by the object detection model.
    """
    from backend.models import Label

    labels = None
    with open(current_app.root_path + '/ml/yolo/labels.json') as f:
        labels = json.load(f)
        labels = [Label(id=index, name=labels[index]) for index in labels]

    db_session.query(Label).delete()
    db_session.add_all(labels)
    db_session.commit()

    click.echo(
        f"Updated the detection labels in database: {len(labels)} Labels.")


def init_app(app: Flask):
    app.cli.add_command(update_labels)
