#!/usr/bin/env sh
./configure --prefix=/home/uki/.local --bindir=/home/uki/bin \
    --with-gsettings --without-gconf --without-sound --with-dbus \
    --without-toolkit-scroll-bars --without-pop --with-xwidgets \
    --with-x-toolkit=gtk3 --with-mailutils --with-modules \
    --enable-link-time-optimization --without-compress-install
