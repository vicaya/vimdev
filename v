#!/bin/sh

cimg=vicaya/vimdev
self=${0##*/}

case "$self" in
  v) set -- "$cimg" "$@";;
  s) set -- --entrypoint=bash "$cimg" "$@";;
  *) echo "Sorry, don't know about $self!"; exit 1;;
esac

uid=${VIMDEV_UID:-$(id -u)}
gid=$(id -g)
cid=$(docker container create -it --rm \
      -v "$PWD":/workspace -v "$HOME/.ssh:/home/.ssh" \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -e USER="$USER" -u "$uid:$gid" "$@")
ptmp="ptmp$$"
docker cp "$cid:/etc/passwd" "$ptmp"
echo "$USER:x:$uid:$gid:generated:/home:/bin/bash" >> "$ptmp"
docker cp "$ptmp" "$cid:/etc/passwd"
rm -f "$ptmp"
docker container start -ia "$cid"
