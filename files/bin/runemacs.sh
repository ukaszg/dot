#!/usr/bin/env sh
if [ -z $1 ]; then
    exec emacs
else
    FILENAME=$(wslpath -u "$1")

    pidof emacs 1>/dev/null 2>&1 && \
        emacsclient -n $FILENAME || \
        exec emacs $FILENAME
fi
