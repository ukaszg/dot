#!/usr/bin/env bash

TRANSLATE=0
[ $1 = '-p' ] && {
    TRANSLATE=1
    shift 1
}

[ $# = 1 ] || {
    echo "Usage:    $0 [options] 'ENV_NAME'" >&2
    echo "      Options:" >&2
    echo "      -p  translate from windows path to wsl" >&2
    exit 1
}

VALUE=$(powershell.exe "[System.Environment]::GetEnvironmentVariable(\"$1\")")

[ "$TRANSLATE" = "1" ] && { VALUE=$(wslpath -a -u "$VALUE"); }

exec echo "$VALUE"
