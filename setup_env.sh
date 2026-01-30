#!/usr/bin/env bash
set -ex

apt-get install -y --no-install-recommends \
    git \
    curl \
    rsync \
    psmisc \
    xfconf \
    xfce4-whiskermenu-plugin \
    xfce4-docklike-plugin

apt-get clean
rm -rf /var/lib/apt/lists/*



#    xfce4-genmon-plugin