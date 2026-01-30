#!/usr/bin/env bash

# 获取脚本所在目录
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 定义图标路径
readonly ICON="${DIR}/icons/network/globe.svg"

# 自动检测活跃网卡 (防止不同 Kasm 镜像网卡名不同)
INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
[[ -z "$INTERFACE" ]] && echo -e "<txt>Offline</txt><tool>No active interface</tool>" && exit

# 路径变量
RX_PATH="/sys/class/net/${INTERFACE}/statistics/rx_bytes"
TX_PATH="/sys/class/net/${INTERFACE}/statistics/tx_bytes"

# 采样 1：获取初始值
PRX=$(cat "$RX_PATH")
PTX=$(cat "$TX_PATH")
T1=$(date +%s%N)

sleep 1 # 采样间隔 1 秒

# 采样 2：获取结束值
CRX=$(cat "$RX_PATH")
CTX=$(cat "$TX_PATH")
T2=$(date +%s%N)

# 计算差值与时间间隔 (纳秒转秒)
DIFF_RX=$(( CRX - PRX ))
DIFF_TX=$(( CTX - PTX ))
DIFF_T=$(( T2 - T1 ))

# 计算每秒字节 (使用 awk 避开 bc 依赖，更通用)
# $1=数据差, $2=时间差(纳秒)
function format_speed () {
    awk -v bytes="$1" -v ns="$2" 'BEGIN {
        speed = bytes / (ns / 1000000000);
        split("B/s KB/s MB/s GB/s", unit, " ");
        i = 1;
        while (speed >= 1024 && i < 4) {
            speed /= 1024;
            i++;
        }
        printf "%.1f %s", speed, unit[i];
    }'
}

RX_SPEED=$(format_speed $DIFF_RX $DIFF_T)
TX_SPEED=$(format_speed $DIFF_TX $DIFF_T)

# 输出到 Panel
if [[ -f "$ICON" ]]; then
    INFO="<img>${ICON}</img>"
else
    INFO=""
fi

# 格式：显示下载(D)和上传(U)
INFO+="<txt> D: $RX_SPEED U: $TX_SPEED</txt>"

# 输出到 Tooltip
IP_ADDR=$(hostname -I | awk '{print $1}')
MORE_INFO="<tool>Interface: $INTERFACE\nIP: $IP_ADDR\nTotal RX: $((CRX/1024/1024)) MB\nTotal TX: $((CTX/1024/1024)) MB</tool>"

echo -e "${INFO}"
echo -e "${MORE_INFO}"

##!/usr/bin/env bash
#
#readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#
## Icon path
#readonly ICON="${DIR}/icons/network/globe.svg"
#
## Displays network interface dengan ipv4 (local)
#readonly TOOLTIP=$(ship --ipv4)
#
## Offline
#ip route | grep ^default &>/dev/null || \
#  echo -ne "<txt> Offline</txt>" || \
#    echo -ne "<tool> Offline</tool>" || \
#      exit
#
## Interface unknown
#test -d "/sys/class/net/eth0" || \
#  echo -ne "<txt>Invalid</txt>" || \
#    echo -ne "<tool>Interface not found</tool>" || \
#      exit
## PRX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/rx_bytes")
#PTX=$(awk '{print $0}' "/sys/class/net/wlp3s0/statistics/tx_bytes")
#sleep 1
## CRX=$(awk '{print $0}' "/sys/class/net/${INTERFACE}/statistics/rx_bytes")
#CTX=$(awk '{print $0}' "/sys/class/net/wlp3s0/statistics/tx_bytes")
#
## BRX=$(( CRX - PRX ))
#BTX=$(( CTX - PTX ))
#
#function hasil_untuk_panel () {
#
#  local BANDWIDTH="${1}"
#  local P=1
#
#  while [[ $(echo "${BANDWIDTH}" '>' 1024 | bc -l) -eq 1 ]]; do
#    BANDWIDTH=$(awk '{$1 = $1 / 1024; printf "%.2f", $1}' <<< "${BANDWIDTH}")
#    P=$(( P + 1 ))
#  done
#
#  case "${P}" in
#    0) BANDWIDTH="${BANDWIDTH} B/s" ;;
#    1) BANDWIDTH="${BANDWIDTH} KB/s" ;;
#    2) BANDWIDTH="${BANDWIDTH} MB/s" ;;
#    3) BANDWIDTH="${BANDWIDTH} GB/s" ;;
#  esac
#
#  echo -e "${BANDWIDTH}"
#
#  return 1
#}
#
## RX=$(hasil_untuk_panel ${BRX})
#TX=$(hasil_untuk_panel ${BTX})
#
## Panel
#if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
#  INFO="<img>${ICON}</img>"
#  if hash xfce4-taskmanager &> /dev/null; then
#    INFO+="<click>xfce4-taskmanager</click>"
#  fi
#  INFO+="<txt>"
#else
#  INFO="<txt>"
#fi
#INFO+=" ${TX}"
#INFO+="</txt>"
#
## Tooltip
#MORE_INFO="<tool>"
#MORE_INFO+="${TOOLTIP}"
#MORE_INFO+="</tool>"
#
## Panel Print
#echo -e "${INFO}"
#
## Tooltip Print
#echo -e "${MORE_INFO}"
