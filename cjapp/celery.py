from __future__ import absolute_import, unicode_literals

import os
from celery import Celery
from django.conf import settings

# set the default Django settings module for the 'celery' program.

def add_env_related_argument_to_worker(parser):
    parser.add_argument(
        '--runserver_local', help='Hadoop queue to be used by the worker'
    )
    parser.add_argument(
        '--runserver_dev', help='Hadoop queue to be used by the worker'
    )

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'cjapp.settings')

app = Celery('cjapp')
app.user_options['worker'].add(add_env_related_argument_to_worker)

# Using a string here means the worker don't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)