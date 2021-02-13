#!/bin/sh

# use entr to watch for files
echo "beginning watch"
# sleep 20000
while true; do
    find /src | entr -d build
done