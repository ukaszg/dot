#!/bin/sh

powershell.exe -command 'Get-Clipboard' 2> /dev/null \
    | dos2unix
#    | tr -d '\r'
