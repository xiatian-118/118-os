#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive

echo "开始配置软件源并安装插件..."
apt-get update
apt-get install -y --no-install-recommends software-properties-common gpg-agent
apt-get install -y --no-install-recommends \
    git \
    curl \
    rsync \
    psmisc \
    xfconf \
    libdisplay-info3 \
    xfce4-whiskermenu-plugin

apt-get clean
rm -rf /var/lib/apt/lists/*



#    xfce4-genmon-plugin