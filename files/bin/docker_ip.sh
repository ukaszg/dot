#!/bin/sh

while [ -n "${1}" ]
do
    printf "%s\t$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${1}")" "${1}"
    shift 1
done
