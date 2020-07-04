#!/usr/bin/env bash
set -xe
#set user and group id, usefull when using mounted dirs.

#functions
setUid(){
  # Setup user/group ids
if [ ! -z "${NTOP_UID}" ]; then
  if [ ! "$(id -u ntopng)" -eq "${NTOP_UID}" ]; then

    # usermod likes to chown the home directory, so create a new one and use that
    # However, if the new UID is 0, we can't set the home dir back because the
    # UID of 0 is already in use (executing this script).
    if [ ! "${NTOP_UID}" -eq 0 ]; then
      mkdir /tmp/temphome
      usermod -d /tmp/temphome ntopng
    fi

    # Change the UID
    usermod -o -u "${NTOP_UID}" ntopng

    # Cleanup the temp home dir
    if [ ! "${NTOP_UID}" -eq 0 ]; then
      usermod -d /home/ntopng ntopng
      rm -Rf /tmp/temphome
    fi
  fi
fi
}

setGid(){
  if [ ! -z "${NTOP_GID}" ]; then
  if [ ! "$(id -g ntopng)" -eq "${NTOP_GID}" ]; then
    groupmod -o -g "${NTOP_GID}" ntopng
  fi
fi
}

#Main
setUid
setGid
echo find
find / -iname ntopng -type f
ntopng "$@"