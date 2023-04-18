import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from backend.database import db_session
from backend.models import Label

bp = Blueprint('detection', __name__, url_prefix='/detection')


@bp.get('/labels')
def labels():
    labels = db_session.query(Label).all()
    return labels
