#!/bin/sh

# use entr to watch for files in "home/worker-hugo/site
echo "beginning watch on /home/worker-hugo/site"

# while true; do
#     find /home/worker-hugo/site | entr -d copy
# done
while true; do
    find /home/worker-hugo/site | entr -d echo 'fuck'
done