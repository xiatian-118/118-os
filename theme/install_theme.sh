#!/usr/bin/env bash
set -ex

# 安装必要的程序
apt-get update
apt-get install -y --no-install-recommends git curl rsync

# 复制主题
cp -r /tmp/theme/Orchis-Dark* /usr/share/themes/
mkdir -p /home/kasm-default-profile/.config/gtk-4.0
cp -r /tmp/theme/Orchis-Dark/gtk-4.0/* /home/kasm-default-profile/.config/gtk-4.0/

