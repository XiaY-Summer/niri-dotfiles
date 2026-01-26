#!/usr/bin/env bash

# --- 配置路径 ---
CONFIG="$HOME/.config/wofi/config/config"
STYLE="$HOME/.config/wofi/src/mocha/style.css"

# --- 选项定义 (统一图标与文字的间距) ---
# 建议使用 Nerd Fonts 以获得更美观的图标
ICON_LOGOUT="󰍃"
ICON_SLEEP="󰒲"
ICON_REBOOT="󰑓"
ICON_POWER="󰐥"

# 统一格式: "图标  操作名称"
OP_EXIT="$ICON_LOGOUT  注销"
OP_SUSP="$ICON_SLEEP  休眠"
OP_REBT="$ICON_REBOOT  重启"
OP_OFF="$ICON_POWER  关机"

# 组合选项
OPTIONS="$OP_EXIT\n$OP_SUSP\n$OP_REBT\n$OP_OFF"

# --- 执行逻辑 ---
if [[ ! $(pidof wofi) ]]; then
    # 使用 --cache-file /dev/null 确保顺序固定，不会因点击频率改变位置
    choice=$(echo -e "$OPTIONS" | wofi --conf "${CONFIG}" --style "${STYLE}" --dmenu --cache-file /dev/null | xargs)

    case "$choice" in
        "$OP_EXIT")
            niri msg action quit ;;
        "$OP_SUSP")
            systemctl suspend ;;
        "$OP_REBT")
            systemctl reboot ;;
        "$OP_OFF")
            systemctl poweroff ;;
    esac
else
    pkill wofi
fi
