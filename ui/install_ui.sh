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
# 更新图标缓存：这对于图标显示至关重要
find /usr/share/icons -maxdepth 1 -type d -exec gtk-update-icon-cache -f -t {} \; 2>/dev/null || true


# 复制壁纸
cp -af "$TMP_UI/wallpapers/." /usr/share/backgrounds/

# 复制字体
FONT_DEST="/usr/share/fonts/truetype/apple-fonts"
mkdir -p "$FONT_DEST"
cp -af "$TMP_UI/fonts/." "$FONT_DEST/"
chown -R root:root "$FONT_DEST"
find "$FONT_DEST" -type d -exec chmod 755 {} +
find "$FONT_DEST" -type f -exec chmod 644 {} +
fc-cache -f



# 最后复制配置
cp -af "$TMP_UI/kasm-default-profile/." "$KDP/"

chown -R 1000:1000 "$KDP"
# 确保 genmon 脚本具有执行权限
#chmod +x "$KDP/.config/xfce4/genmon/"*.sh 2>/dev/null || true




# 复制字体

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