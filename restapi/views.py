# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.http import HttpResponse
#from django.shortcuts import render
from restapi import tasks
# Create your views here.


def index(requests):
    return HttpResponse("Hello, world. You're at Rest.")


def sample_celery(requests):
    try:
        tasks.execute_run.delay()
    except Exception as ex:
        print(ex)
    return HttpResponse("Sent Message.")
