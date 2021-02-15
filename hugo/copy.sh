#!/bin/sh

# entr command isn't working without this as a sciript, really annoying
cp -r /home/worker-hugo/site/* /site
# set permissions to host UID and GID
GID=$(cat /GID)
UID=$(cat /UID)
chown -R $UID:$GID /site