#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    git \
    curl \
    rsync \
    psmisc \
    xfconf \
    xfce4-whiskermenu-plugin

apt-get clean
rm -rf /var/lib/apt/lists/*



#    xfce4-genmon-plugin