#!/usr/bin/env bash
flatpak list | awk '{print $2}' > packages.txt
xargs -a /var/home/larks/Documents/Creative/packages2.txt flatpak install
SRCDIR="/var/home/larks/.var/app"
DESTDIR="/var/home/larks/"
FILENAME=flatpakbackup-$(date +%-Y%-m%-d)-$(date +%-T).tgz 
tar --create --gzip --file=$DESTDIR$FILENAME $SRCDIR