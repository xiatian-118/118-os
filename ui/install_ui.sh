#!/usr/bin/env bash
set -ex

# 定义变量
KDP="/home/kasm-default-profile"
TMP_UI="/tmp/ui"

# 创建目录
mkdir -p "$KDP/.config"

# 复制主题
cp -af "$TMP_UI/themes/." /usr/share/themes/
cp -af "$TMP_UI/themes/Orchis-Dark/gtk-4.0" "$KDP/.config/"

# 复制图标
tar -xzvf "$TMP_UI/icons/icons.tar.gz" -C /usr/share/icons/

# 复制壁纸
cp -af "$TMP_UI/wallpapers/." /usr/share/backgrounds/

# 复制配置
cp -af "$TMP_UI/kasm-default-profile/." "$KDP/"


# 复制字体
#FONT_DEST="/usr/share/fonts/truetype/apple-fonts"
#mkdir -p "$FONT_DEST"
#cp -f /tmp/theme/fonts/*.ttf "$FONT_DEST/"
#cp -f /tmp/theme/fonts/*.ttc "$FONT_DEST/"
#chmod 644 "$FONT_DEST"/*
#cat > /etc/fonts/conf.d/99-apple-fonts.conf <<EOF
#<?xml version="1.0"?>
#<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
#<fontconfig>
#  <match target="font">
#    <edit name="antialias" mode="assign"><bool>true</bool></edit>
#    <edit name="hinting" mode="assign"><bool>true</bool></edit>
#    <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
#    <edit name="rgba" mode="assign"><const>rgb</const></edit>
#    <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>
#  </match>
#
#  <alias>
#    <family>sans-serif</family>
#    <prefer>
#      <family>SF Pro</family>
#      <family>PingFang SC</family>
#      <family>Thonburi</family>
#      <family>.ThonburiUI</family>
#      <family>Noto Sans CJK SC</family>
#    </prefer>
#  </alias>
#
#  <match target="pattern">
#    <test name="family"><string>Microsoft YaHei</string></test>
#    <edit name="family" mode="assign" binding="strong">
#      <string>PingFang SC</string>
#    </edit>
#  </match>
#</fontconfig>
#EOF
#fc-cache -fv

# 打入 xfce xml 配置
#DEST="/home/kasm-kasm-default-profile/.config/xfce4/xfconf/xfce-perchannel-xml"
#mkdir -p "$DEST"
#cp -f /tmp/ui/xfce-.config/*.xml "$DEST/"