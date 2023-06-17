#!/bin/bash

# Activate virtual environment
. .venv/bin/activate

# Init database (this erases the db, and updates the schema)
# flask --app backend init-db
# rm -r instance/*

# Update labels in database
flask --app backend update-labels

# Make LaMa directories
mkdir -p backend/ml/Inpainter/lama_input
mkdir -p backend/ml/Inpainter/lama_output

# Run flask app
flask --app backend run --debug --host 0.0.0.0 --port 80 &

# Run celery worker
watchmedo auto-restart --directory backend --pattern tasks.py -- celery -A backend.celery_app worker --concurrency=1 --loglevel=INFO &

wait