#!/bin/sh
if [ -z $1 ]; then
    setsid emacs
else
    FILENAME=$(wslpath -u "$1")

    pidof emacs 1>/dev/null 2>&1 && \
        emacsclient -n $FILENAME || \
        setsid emacs $FILENAME
fi
