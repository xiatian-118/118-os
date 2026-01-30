#!/usr/bin/env bash
set -ex


apt-get update
apt-get install -y --no-install-recommends \
    software-properties-common \
    lsb-release \
    ca-certificates \
    gnupg2 \
    git \
    curl \
    rsync \
    psmisc \
    xfconf

add-apt-repository -y ppa:xubuntu-dev/staging
apt-get update
apt-get install -y --no-install-recommends \
    xfce4-whiskermenu-plugin \
    xfce4-docklike-plugin \
    xfce4-genmon-plugin

apt-get clean
rm -rf /var/lib/apt/lists/*