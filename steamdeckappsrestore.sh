#!/usr/bin/env bash
SRCDIR="/run/media/mmcblk0pl1/flatpakbackup-$(date +%-Y%-m%-d)-$(date +%-T).tgz"
DESTDIR="/var/home/deck/.var/app"
FILENAME=flatpakbackup-$(date +%-Y%-m%-d)-$(date +%-T).tgz
flatpak list | awk '{print $2}' > packages.txt
xargs -a /var/home/deck/packages.txt flatpak install
