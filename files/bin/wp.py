#!/usr/bin/env python3

from os import environ, listdir, system, path
from random import choice

if __name__ == '__main__':
    wp_dir = "/".join([environ['HOME'], "pic/wp"])
    if path.isdir(wp_dir):
        wallpaper = "/".join([wp_dir, choice(listdir(wp_dir))]).replace(' ', r'\ ')
        system(" ".join(["hsetroot -full", wallpaper]))
