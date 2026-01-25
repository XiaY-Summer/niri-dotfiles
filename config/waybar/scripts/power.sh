#!/usr/bin/env bash

CONFIG="$HOME/.config/wofi/config/config"
STYLE="$HOME/.config/wofi/src/mocha/style.css"

if [[ ! $(pidof wofi) ]]; then
    choice=$(printf "⎋ 注销\n⏼ 休眠\n↻ 重启\n⏻ 关机" | wofi --conf "${CONFIG}" --style "${STYLE}" -dmenu)
    case "$choice" in
        *注销*) niri msg action quit ;;
        *休眠*) systemctl suspend ;;
        *重启*) systemctl reboot ;;
        *关机*) systemctl poweroff ;;
    esac
else
    pkill wofi
fi
