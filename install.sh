#!/bin/bash

#chmod +x config
#cp -r config/* ~/.config

# 1. 更新系统并安装所有依赖 (全部来自官方仓库)
echo "正在通过 pacman 安装所有依赖..."
sudo pacman -Syu --needed \
    niri kitty waybar wofi mako fastfetch swww swaylock nwg-look \
    brightnessctl playerctl wireplumber pavucontrol \
    yazi firefox polkit-gnome ethtool \
    ttf-jetbrains-mono-nerd ttf-inconsolata-nerd noto-fonts-cjk

# 2. 创建配置目录
echo "正在同步配置文件..."
mkdir -p ~/.config

# 3. 复制配置 (假设 config 文件夹在当前目录下)
cp -r config/* ~/.config/

# 4. 赋予脚本执行权限
# run.sh 用于启动 wofi
# power.sh 用于电源菜单
echo "设置脚本权限..."
chmod +x ~/.config/niri/scripts/run.sh
chmod +x ~/.config/waybar/scripts/power.sh

echo "--------------------------------------------------"
echo "安装完成！"
echo "请注销并在登录管理器中选择 'niri' 会话。"
echo "快捷键提示:"
echo " - Mod + Return: 打开终端 (Kitty)"
echo " - Mod + D: 应用启动器 (Wofi)"
echo " - Mod + E: 文件管理器 (Yazi)"
echo " - Mod + B: 浏览器 (Firefox)"
