#!/usr/bin/env bash
set -ex

# 定义变量
KDP="/home/kasm-default-profile"
TMP_UI="/tmp/ui"

# 安装依赖
cd "${TMP_UI}/deb"
#dpkg -i libdisplay-info3_0.3.0-1_amd64.deb
#dpkg -i libxfce4windowing-common_4.20.5-1_all.deb
#dpkg -i --force-depends libxfce4windowing-0-0_4.20.5-1_amd64.deb
#dpkg -i --force-depends xfce4-docklike-plugin_0.5.0-1_amd64.deb
dpkg -i --force-depends xfce4-docklike-plugin_0.4.3-1_amd64.deb
ldconfig
apt-mark hold xfce4-docklike-plugin



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
fc-cache -f

# 最后复制配置
cp -af "$TMP_UI/kasm-default-profile/." "$KDP/"
