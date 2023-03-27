#!/usr/bin/env bash
SRCDIR="/var/home/deck/.var/app"
DESTDIR="/run/media/mmcblk0pl1"
FILENAME=flatpakbackup-$(date +%-Y%-m%-d)-$(date +%-T).tgz 
tar --create --gzip --file=$DESTDIR$FILENAME $SRCDIR