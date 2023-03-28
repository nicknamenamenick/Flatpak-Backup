#!/usr/bin/env bash
flatpak list | awk '{print $2}' > packages.txt
xargs -a /var/home/deck/packages.txt flatpak install
unzip ‘/run/media/mmcblk0pl1/flatpakbackup-$(date +%-Y%-m%-d)-$(date +%-T).tgz’ -d /var/home/deck/.var/app