#!/bin/bash

# ============================================================================
#  Niri Dotfiles Installer
#  https://github.com/your-repo/niri-dotfiles
# ============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# 符号定义
CHECKMARK="${GREEN}✓${NC}"
CROSSMARK="${RED}✗${NC}"
ARROW="${CYAN}➜${NC}"
INFO="${BLUE}ℹ${NC}"
WARN="${YELLOW}⚠${NC}"

# 配置
BACKUP_DIR="$HOME/Documents/niri-dotfiles-backup"
CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 需要安装的配置列表
CONFIG_ITEMS=(
    "niri"
    "kitty"
    "waybar"
    "wofi"
    "mako"
    "fastfetch"
    "nwg-look"
)

# ============================================================================
#  工具函数
# ============================================================================

print_header() {
    echo
    echo -e "${PURPLE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}          ${WHITE}Niri Dotfiles Installer${NC}                          ${PURPLE}║${NC}"
    echo -e "${PURPLE}║${NC}          ${CYAN}美观 · 高效 · 现代化的桌面配置${NC}                   ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo
}

print_step() {
    echo -e "\n${ARROW} ${WHITE}$1${NC}"
    echo -e "  ${CYAN}────────────────────────────────────────${NC}"
}

print_success() {
    echo -e "  ${CHECKMARK} $1"
}

print_error() {
    echo -e "  ${CROSSMARK} $1"
}

print_info() {
    echo -e "  ${INFO} $1"
}

print_warn() {
    echo -e "  ${WARN} $1"
}

# 确认操作
confirm() {
    local prompt="$1"
    local default="${2:-y}"
    
    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi
    
    read -r -p "$(echo -e "  ${YELLOW}?${NC} $prompt")" response
    response="${response:-$default}"
    
    [[ "$response" =~ ^[Yy]$ ]]
}

# ============================================================================
#  备份功能
# ============================================================================

backup_configs() {
    print_step "备份现有配置文件"
    
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_path="${BACKUP_DIR}/${timestamp}"
    local backed_up=0
    
    # 确保 Documents 目录存在
    mkdir -p "$HOME/Documents"
    
    # 检查是否有需要备份的配置
    local has_existing=false
    for item in "${CONFIG_ITEMS[@]}"; do
        if [[ -e "$CONFIG_DIR/$item" ]]; then
            has_existing=true
            break
        fi
    done
    
    if [[ "$has_existing" == false ]]; then
        print_info "没有发现现有配置文件，跳过备份"
        return 0
    fi
    
    # 创建备份目录
    mkdir -p "$backup_path"
    print_info "备份目录: ${CYAN}$backup_path${NC}"
    echo
    
    for item in "${CONFIG_ITEMS[@]}"; do
        local source="$CONFIG_DIR/$item"
        if [[ -e "$source" ]]; then
            if cp -r "$source" "$backup_path/"; then
                print_success "$item"
                backed_up=$((backed_up + 1))
            else
                print_error "备份 $item 失败"
            fi
        else
            print_info "$item ${YELLOW}(不存在，跳过)${NC}"
        fi
    done
    
    echo
    if [[ $backed_up -gt 0 ]]; then
        print_info "已备份 ${GREEN}$backed_up${NC} 个配置到 ${CYAN}$backup_path${NC}"
        
        # 创建一个符号链接指向最新备份
        local latest_link="${BACKUP_DIR}/latest"
        rm -f "$latest_link"
        ln -s "$backup_path" "$latest_link"
        print_info "最新备份链接: ${CYAN}$latest_link${NC}"
    fi
}

# ============================================================================
#  安装功能
# ============================================================================

install_packages() {
    print_step "安装系统依赖"
    
    local packages=(
        # 核心组件
        "niri"
        "kitty"
        "waybar"
        "wofi"
        "mako"
        "swww"
        "swaylock"
        
        # 工具
        "fastfetch"
        "nwg-look"
        "brightnessctl"
        "playerctl"
        "wireplumber"
        "pavucontrol"
        "yazi"
        "firefox"
        "polkit-gnome"
        "ethtool"
        
        # 字体
        "ttf-jetbrains-mono-nerd"
        "ttf-inconsolata-nerd"
        "noto-fonts-cjk"
    )
    
    print_info "将安装以下软件包:"
    echo
    
    # 分类显示
    echo -e "  ${WHITE}核心组件:${NC} niri, kitty, waybar, wofi, mako, swww, swaylock"
    echo -e "  ${WHITE}实用工具:${NC} fastfetch, nwg-look, yazi, firefox, pavucontrol"
    echo -e "  ${WHITE}系统工具:${NC} brightnessctl, playerctl, wireplumber, polkit-gnome"
    echo -e "  ${WHITE}字体:${NC} JetBrains Mono Nerd, Inconsolata Nerd, Noto CJK"
    echo
    
    if confirm "是否继续安装?" "y"; then
        echo
        sudo pacman -Syu --needed "${packages[@]}"
        echo
        print_success "所有软件包安装完成"
    else
        print_warn "跳过软件包安装"
    fi
}

install_configs() {
    print_step "安装配置文件"
    
    # 确保配置目录存在
    mkdir -p "$CONFIG_DIR"
    
    local installed=0
    
    for item in "${CONFIG_ITEMS[@]}"; do
        local source="$SCRIPT_DIR/config/$item"
        local dest="$CONFIG_DIR/$item"
        
        if [[ -d "$source" ]]; then
            # 删除旧配置（如果存在）
            rm -rf "$dest"
            
            if cp -r "$source" "$dest"; then
                print_success "$item"
                installed=$((installed + 1))
            else
                print_error "安装 $item 失败"
            fi
        else
            print_warn "$item ${YELLOW}(源不存在)${NC}"
        fi
    done
    
    echo
    print_info "已安装 ${GREEN}$installed${NC} 个配置"
}

set_permissions() {
    print_step "设置脚本权限"
    
    local scripts=(
        "$CONFIG_DIR/niri/scripts/run.sh"
        "$CONFIG_DIR/waybar/scripts/power.sh"
    )
    
    for script in "${scripts[@]}"; do
        if [[ -f "$script" ]]; then
            chmod +x "$script"
            print_success "$(basename "$script")"
        else
            print_warn "$(basename "$script") ${YELLOW}(不存在)${NC}"
        fi
    done
}

# ============================================================================
#  完成信息
# ============================================================================

print_completion() {
    echo
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}                    ${WHITE}安装完成!${NC}                               ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "  ${INFO} 请注销并在登录管理器中选择 ${CYAN}niri${NC} 会话"
    echo
    echo -e "  ${WHITE}快捷键提示:${NC}"
    echo -e "  ┌──────────────────┬────────────────────────┐"
    echo -e "  │ ${CYAN}Mod + Return${NC}     │ 打开终端 (Kitty)       │"
    echo -e "  │ ${CYAN}Mod + D${NC}          │ 应用启动器 (Wofi)      │"
    echo -e "  │ ${CYAN}Mod + E${NC}          │ 文件管理器 (Yazi)      │"
    echo -e "  │ ${CYAN}Mod + B${NC}          │ 浏览器 (Firefox)       │"
    echo -e "  │ ${CYAN}Mod + Q${NC}          │ 关闭窗口               │"
    echo -e "  │ ${CYAN}Mod + Shift + E${NC}  │ 退出 Niri              │"
    echo -e "  └──────────────────┴────────────────────────┘"
    echo
    
    if [[ -d "${BACKUP_DIR}/latest" ]]; then
        echo -e "  ${INFO} 配置备份位置: ${CYAN}${BACKUP_DIR}/latest${NC}"
        echo
    fi
}

# ============================================================================
#  帮助信息
# ============================================================================

show_help() {
    echo -e "${WHITE}Niri Dotfiles Installer${NC}"
    echo
    echo -e "${WHITE}用法:${NC}"
    echo "  ./install.sh [选项]"
    echo
    echo -e "${WHITE}选项:${NC}"
    echo "  -h, --help      显示帮助信息"
    echo "  -b, --backup    仅备份配置"
    echo "  -c, --config    仅安装配置 (跳过软件包安装)"
    echo "  -p, --packages  仅安装软件包"
    echo "  --no-backup     跳过备份"
    echo
    echo -e "${WHITE}示例:${NC}"
    echo "  ./install.sh              # 完整安装 (备份 + 软件包 + 配置)"
    echo "  ./install.sh --backup     # 仅备份现有配置"
    echo "  ./install.sh --no-backup  # 安装但不备份"
    echo
}

# ============================================================================
#  主程序
# ============================================================================

main() {
    local do_backup=true
    local do_packages=true
    local do_configs=true
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -b|--backup)
                do_packages=false
                do_configs=false
                ;;
            -c|--config)
                do_packages=false
                ;;
            -p|--packages)
                do_backup=false
                do_configs=false
                ;;
            --no-backup)
                do_backup=false
                ;;
            *)
                print_error "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
        shift
    done
    
    print_header
    
    # 检查是否在正确的目录
    if [[ ! -d "$SCRIPT_DIR/config" ]]; then
        print_error "未找到 config 目录，请确保在正确的位置运行脚本"
        exit 1
    fi
    
    # 执行安装步骤
    [[ "$do_backup" == true ]] && backup_configs
    [[ "$do_packages" == true ]] && install_packages
    [[ "$do_configs" == true ]] && install_configs
    [[ "$do_configs" == true ]] && set_permissions
    
    print_completion
}

main "$@"
