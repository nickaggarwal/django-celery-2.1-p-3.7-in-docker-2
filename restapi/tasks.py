from celery import shared_task
import logging
from cjapp.celery import app
logger = logging.getLogger(__name__)

@app.task
def execute_run():
    logger.info("Executing run-submission task for id:")
    return "Sample Celery"