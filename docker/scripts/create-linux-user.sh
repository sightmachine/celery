#!/bin/sh
addgroup --gid 1019 $CELERY_USER
adduser --system --disabled-password --uid 1019 --gid 1019 $CELERY_USER
