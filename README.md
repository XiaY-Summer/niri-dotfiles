# Niri 配置文件

一个美观且功能完善的 Niri 窗口管理器配置，适用于 Wayland 环境。

![Screenshot](img/Screenshot%20from%202026-01-25%2023-09-17.png)

## 简介

这是一套基于 [Niri](https://github.com/YaLTeR/niri) 的完整 Wayland 桌面环境配置。Niri 是一个可滚动平铺的 Wayland 合成器，具有动态工作区管理功能。本配置集成了常用的 Wayland 工具和应用，提供了开箱即用的桌面体验。

## 特性

- **窗口管理器**: Niri - 支持可滚动平铺布局的现代 Wayland 合成器
- **状态栏**: Waybar - 高度可定制的 Wayland 状态栏
- **应用启动器**: Wofi - 简洁的应用程序启动器
- **通知系统**: Mako - 轻量级通知守护进程
- **终端模拟器**: Kitty - GPU 加速的终端
- **壁纸管理**: swww - 高效的 Wayland 壁纸设置工具
- **屏幕锁定**: swaylock - 简洁的屏幕锁定程序
- **系统信息**: fastfetch - 快速系统信息显示工具
- **文件管理器**: Yazi - 基于终端的文件管理器
- **主题设置**: nwg-look - GTK 主题配置工具

## 系统要求

- Arch Linux 或基于 Arch 的发行版
- Wayland 支持
- 显卡驱动支持 Wayland

## 安装

### 自动安装

运行提供的安装脚本：

```bash
git clone <repository-url> niri_config
cd niri_config
chmod +x install.sh
./install.sh
```

安装脚本会自动完成以下操作：
1. 通过 pacman 安装所有必需的依赖包
2. 创建配置目录
3. 复制配置文件到 `~/.config/`
4. 设置脚本执行权限

### 手动安装

如果你想手动安装，按照以下步骤：

1. 安装依赖包：

```bash
sudo pacman -Syu --needed \
    niri kitty waybar wofi mako fastfetch swww swaylock nwg-look \
    brightnessctl playerctl wireplumber pavucontrol \
    yazi firefox polkit-gnome ethtool \
    ttf-jetbrains-mono-nerd ttf-inconsolata-nerd noto-fonts-cjk
```

2. 复制配置文件：

```bash
mkdir -p ~/.config
cp -r config/* ~/.config/
```

3. 设置脚本权限：

```bash
chmod +x ~/.config/niri/scripts/run.sh
chmod +x ~/.config/waybar/scripts/power.sh
```

## 已安装的软件包说明

### 核心组件
- **niri**: 窗口管理器
- **kitty**: 终端模拟器
- **waybar**: 状态栏
- **wofi**: 应用启动器
- **mako**: 通知守护进程

### 系统工具
- **fastfetch**: 系统信息显示
- **swww**: 壁纸管理
- **swaylock**: 屏幕锁定
- **nwg-look**: GTK 主题工具

### 音频和媒体控制
- **brightnessctl**: 亮度控制
- **playerctl**: 媒体播放器控制
- **wireplumber**: PipeWire 会话管理器
- **pavucontrol**: 图形化音量控制器

### 应用程序
- **yazi**: 终端文件管理器
- **firefox**: 网页浏览器

### 系统服务
- **polkit-gnome**: 图形化权限验证
- **ethtool**: 网络接口工具

### 字体
- **ttf-jetbrains-mono-nerd**: JetBrains Mono Nerd Font
- **ttf-inconsolata-nerd**: Inconsolata Nerd Font
- **noto-fonts-cjk**: 中日韩字体支持

## 使用方法

### 启动 Niri

1. 注销当前会话
2. 在登录管理器中选择 "Niri" 会话
3. 登录

### 快捷键

#### 应用程序启动
- `Mod + Return`: 打开终端 (Kitty)
- `Mod + D`: 应用启动器 (Wofi)
- `Mod + E`: 文件管理器 (Yazi)
- `Mod + B`: 浏览器 (Firefox)
- `Super + Alt + L`: 锁屏 (swaylock)

#### 窗口管理
- `Mod + Q`: 关闭窗口
- `Mod + Left/H`: 聚焦左侧窗口
- `Mod + Right/L`: 聚焦右侧窗口
- `Mod + Up/K`: 聚焦上方窗口
- `Mod + Down/J`: 聚焦下方窗口
- `Mod + F`: 最大化列
- `Mod + Shift + F`: 全屏窗口
- `Mod + V`: 切换浮动/平铺模式
- `Mod + W`: 切换标签页显示模式

#### 窗口移动
- `Mod + Ctrl + Left/H`: 向左移动窗口
- `Mod + Ctrl + Right/L`: 向右移动窗口
- `Mod + Ctrl + Up/K`: 向上移动窗口
- `Mod + Ctrl + Down/J`: 向下移动窗口

#### 工作区管理
- `Mod + 1-9`: 切换到工作区 1-9
- `Mod + Ctrl + 1-9`: 移动窗口到工作区 1-9
- `Mod + U/Page_Down`: 切换到下一个工作区
- `Mod + I/Page_Up`: 切换到上一个工作区
- `Mod + O`: 打开概览视图

#### 显示器管理
- `Mod + Shift + Left/H`: 聚焦左侧显示器
- `Mod + Shift + Right/L`: 聚焦右侧显示器
- `Mod + Shift + Ctrl + Left/H`: 移动窗口到左侧显示器
- `Mod + Shift + Ctrl + Right/L`: 移动窗口到右侧显示器

#### 窗口大小调整
- `Mod + R`: 切换预设列宽
- `Mod + Shift + R`: 切换预设窗口高度
- `Mod + Minus`: 减小列宽 10%
- `Mod + Equal`: 增大列宽 10%
- `Mod + Shift + Minus`: 减小窗口高度 10%
- `Mod + Shift + Equal`: 增大窗口高度 10%

#### 媒体控制
- `XF86AudioRaiseVolume`: 增加音量
- `XF86AudioLowerVolume`: 降低音量
- `XF86AudioMute`: 静音/取消静音
- `XF86AudioPlay`: 播放/暂停
- `XF86AudioNext`: 下一首
- `XF86AudioPrev`: 上一首

#### 亮度调节
- `XF86MonBrightnessUp`: 增加亮度
- `XF86MonBrightnessDown`: 降低亮度

#### 截图
- `Print`: 截取区域
- `Ctrl + Print`: 截取整个屏幕
- `Alt + Print`: 截取当前窗口

#### 系统
- `Mod + Shift + /`: 显示快捷键帮助
- `Mod + Shift + E`: 退出 Niri (显示确认对话框)
- `Ctrl + Alt + Delete`: 退出 Niri
- `Mod + Shift + P`: 关闭显示器

> **注意**: `Mod` 键在 TTY 下是 `Super` 键（Windows 键），在窗口模式下是 `Alt` 键。

## 配置文件说明

### 目录结构

```
config/
├── niri/
│   ├── config.kdl          # Niri 主配置文件
│   ├── scripts/
│   │   └── run.sh          # Wofi 启动脚本
│   └── wallhaven/
│       └── wall.jpg        # 壁纸文件
├── waybar/
│   ├── config              # Waybar 配置
│   ├── style.css           # Waybar 样式
│   └── scripts/
│       └── power.sh        # 电源菜单脚本
├── wofi/
│   ├── config/
│   │   └── config          # Wofi 配置
│   ├── src/                # Catppuccin 主题文件
│   └── colors.css          # 颜色定义
├── kitty/
│   └── kitty.conf          # Kitty 终端配置
├── mako/
│   └── config              # Mako 通知配置
├── fastfetch/
│   └── config.jsonc        # Fastfetch 配置
└── nwg-look/
    └── config              # GTK 主题配置
```

### 配置自定义

#### 更换壁纸

将你的壁纸放在 `~/.config/niri/wallhaven/` 目录下，并修改 `config.kdl`:

```kdl
spawn-at-startup "sh -c 'sleep 1 && swww img ~/.config/niri/wallhaven/your-wallpaper.jpg'"
```

#### 修改 Waybar

编辑 `~/.config/waybar/config` 和 `~/.config/waybar/style.css` 来自定义状态栏的外观和功能。

#### 更改主题

使用 `nwg-look` 来选择 GTK 主题、图标和字体：

```bash
nwg-look
```

#### 修改输出设置

编辑 `~/.config/niri/config.kdl` 中的 `output` 部分来配置你的显示器：

```kdl
output "YOUR-MONITOR" {
    mode "1920x1080@60.000"
    scale 1.0
    position x=0 y=0
}
```

运行 `niri msg outputs` 查看你的显示器名称和支持的模式。

## 自动启动程序

配置文件中已设置以下自动启动程序：

- Waybar (状态栏)
- swww-daemon (壁纸守护进程)
- 壁纸加载
- polkit-gnome (权限认证)
- 网络唤醒设置 (Wake-on-LAN)

如需添加其他自动启动程序，在 `~/.config/niri/config.kdl` 中添加：

```kdl
spawn-at-startup "你的程序"
```

## 故障排除

### Waybar 不显示

检查 Waybar 是否正在运行：

```bash
pgrep waybar
```

如果没有运行，手动启动：

```bash
waybar &
```

### 壁纸不显示

确保 swww 守护进程正在运行：

```bash
pgrep swww-daemon
```

手动设置壁纸：

```bash
swww img ~/.config/niri/wallhaven/wall.jpg
```

### 字体显示异常

确认 Nerd Fonts 已正确安装：

```bash
fc-list | grep -i nerd
```

### 音频不工作

检查 PipeWire 和 WirePlumber 是否运行：

```bash
systemctl --user status pipewire wireplumber
```

### 屏幕锁定不工作

确保 swaylock 已安装并有权限：

```bash
which swaylock
```

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

## 许可证

本项目配置文件采用开源许可。请注意各个软件组件有各自的许可证。

## 相关链接

- [Niri 官方文档](https://yalter.github.io/niri/)
- [Niri GitHub](https://github.com/YaLTeR/niri)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Arch Wiki - Wayland](https://wiki.archlinux.org/title/Wayland)

## 致谢

- Niri 开发者和贡献者
- Waybar 项目
- Catppuccin 主题 (Wofi 配置使用)
- Arch Linux 社区
