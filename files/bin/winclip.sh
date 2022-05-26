#!/bin/sh

powershell.exe -command 'Get-Clipboard' 2> /dev/null \
    | tr -d '\r'
