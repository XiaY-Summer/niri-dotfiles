#!/usr/bin/env bash

# --- 配置路径 ---
CONFIG="$HOME/.config/wofi/config/config"
STYLE="$HOME/.config/wofi/src/mocha/style.css"

# --- 选项定义 ---
ICON_LOGOUT="󰍃"
ICON_SLEEP="󰒲"
ICON_REBOOT="󰑓"
ICON_POWER="󰐥"

OP_EXIT="$ICON_LOGOUT  注销"
OP_SUSP="$ICON_SLEEP  休眠"
OP_REBT="$ICON_REBOOT  重启"
OP_OFF="$ICON_POWER  关机"

OPTIONS="$OP_EXIT\n$OP_SUSP\n$OP_REBT\n$OP_OFF"

if ! pgrep -x "wofi" > /dev/null; then
    choice=$(echo -e "$OPTIONS" | wofi --conf "${CONFIG}" --style "${STYLE}" --dmenu --cache-file /dev/null)

    if [[ -n "$choice" ]]; then
        case "$choice" in
            "$OP_EXIT")
                niri msg action quit ;;
            "$OP_SUSP")
                systemctl suspend ;;
            "$OP_REBT")
                systemctl reboot ;;
            "$OP_OFF")
                systemctl poweroff ;;
            *)
                notify-send "Power Menu Error" "未匹配的选项: '$choice'" ;;
        esac
    fi
else
    pkill wofi
fi
