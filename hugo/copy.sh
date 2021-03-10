#!/bin/sh
# script copies site files from working directory to volume
# shared with host

cp -r /home/worker-hugo/site/* /site
# set permissions to UID and GID - set in Dockerfile or during build
GID=$(cat /GID)
UID=$(cat /UID)
chown -R $UID:$GID /site