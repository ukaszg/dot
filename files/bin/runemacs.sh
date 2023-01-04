#!/bin/sh
FILENAME=$(wslpath -u "$1")

pidof emacs 1>/dev/null 2>&1 && \
    emacsclient -n $FILENAME || \
    setsid emacs $FILENAME
