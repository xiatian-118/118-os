#!/usr/bin/env bash
set -ex

apt-get update
apt-get upgrade -y

# 确保 universe 仓库已启用 (Docklike 等插件通常在此仓库)
apt-get install -y --no-install-recommends software-properties-common
add-apt-repository -y universe

apt-get install -y --no-install-recommends \
    git \
    curl \
    rsync \
    psmisc \
    xfconf \
    xfce4-whiskermenu-plugin \
    xfce4-docklike-plugin \
    xfce4-genmon-plugin
apt-get clean
rm -rf /var/lib/apt/lists/*