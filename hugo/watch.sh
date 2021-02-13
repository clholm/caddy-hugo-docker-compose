#!/bin/sh

# use entr to watch for files in /src
echo "beginning watch on /src"
# sleep 20000
while true; do
    find /src | entr -d build
done