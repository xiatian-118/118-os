#!/usr/bin/env bash
set -ex

# 复制主题
cp -r /tmp/theme/Orchis-Dark* /usr/share/themes/
mkdir -p /home/kasm-default-profile/.config/gtk-4.0
cp -r /tmp/theme/Orchis-Dark/gtk-4.0/* /home/kasm-default-profile/.config/gtk-4.0/

# 打入 xfce xml 配置
DEST="/home/kasm-default-profile/.config/xfce4/xfconf/xfce-perchannel-xml"
mkdir -p "$DEST"
cp -f /tmp/theme/xfce-config/*.xml "$DEST/"