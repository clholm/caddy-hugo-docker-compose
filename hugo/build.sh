#!/bin/sh
HUGO_DESTINATION="${HUGO_DESTINATION:=/output}"
echo "HUGO_THEME:" $HUGO_THEME
echo "HUGO_BASEURL" $HUGO_BASEURL
echo "ARGS" $@

HUGO=/usr/local/bin/hugo
echo "Hugo path: $HUGO"

echo "building!"
# copy to directory with write permissions
rsync -a /src /home/worker-hugo/
$HUGO --source="/home/worker-hugo/src" --theme="$HUGO_THEME" --destination="/site" --baseURL="$HUGO_BASEURL" "$@" || exit 1