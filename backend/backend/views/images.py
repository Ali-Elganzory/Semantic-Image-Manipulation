import os
import uuid

from cv2 import imread
from flask import Blueprint, Flask, current_app, request, send_from_directory, url_for

from backend.database import db_session
from backend.models import Image

bp = Blueprint("images", __name__, url_prefix="/images")


@bp.post("/")
def upload_image():
    # Save image to storage
    extension = request.files["file"].filename.split(".")[-1]
    path = os.path.join(
        current_app.config["UPLOAD_FOLDER"], str(uuid.uuid4()) + "." + extension
    )
    request.files["file"].save(path)

    # Extract image info
    height, width, _ = imread(path).shape

    # Save image to database
    image = Image(
        name="New image",
        path=path,
        width=width,
        height=height,
    ).save()

    return {
        "message": "",
        "data": {
            "id": image.id,
            "name": image.name,
            "url": url_for(
                "images.download_image",
                image_filename=image.path.split("/")[-1],
                _external=True,
            ),
            "width": image.width,
            "height": image.height,
        },
    }


@bp.get("/<string:image_filename>")
def download_image(image_filename: str):
    return send_from_directory(
        current_app.config["UPLOAD_FOLDER"],
        image_filename,
    )


@bp.get("modified/<string:image_filename>")
def download_modified_image(image_filename: str):
    return send_from_directory(
        current_app.config["MODIFIED_FOLDER"],
        image_filename,
    )


@bp.get("/")
def get_images():
    images = db_session.query(Image).order_by(Image.id.desc()).all()
    return {
        "message": "",
        "data": [
            {
                "id": image.id,
                "name": image.name,
                "url": url_for(
                    "images.download_image",
                    image_filename=image.path.split("/")[-1],
                    _external=True,
                ),
                "width": image.width,
                "height": image.height,
                "inpainted_url": ""
                if image.inpainted_path is None
                else url_for(
                    "images.download_image",
                    image_filename=image.inpainted_path.split("/")[-1],
                    _external=True,
                ),
            }
            for image in images
        ],
    }


@bp.put("/<int:image_id>")
def update_image(image_id: int):
    image = Image().get(image_id)

    if image is None:
        return {
            "message": "Image not found",
            "data": {},
        }, 404

    image.name = request.json["name"]
    image.update()
    return {
        "message": "",
        "data": {},
    }


def init_app(app: Flask):
    app.register_blueprint(bp)
