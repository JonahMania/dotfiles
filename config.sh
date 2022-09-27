#!/bin/bash

COMMAND=$1
COMMAND_INSTALL="install"
COMMAND_UNINSTALL="uninstall"
COMMAND_REFRESH="refresh"
BASE_HELP="config [${COMMAND_INSTALL}|${COMMAND_UNINSTALL}|${COMMAND_REFRESH}]"
WALLPAPER_DIR="$HOME/.config/wallpaper"
WALLPAPER_FILE="$WALLPAPER_DIR/wallpaper.png"
LOCAL_WALLPAPER_FILE="wallpaper/wallpaper.png"
FONTS_DIR="$HOME/.local/share/fonts"
LOCAL_FONTS_DIR="fonts"
CONFIGS=$(ls config)
PACKAGES=(
    "stow"
    "bspwm"
    "feh"
    "polybar"
    "kitty"
    "neofetch"
    "sxhkd"
    "networkmanager"
    "rofi"
)

function install() {
    # Install packages
    UNAME_OUT=$(uname -a)
    if echo $UNAME_OUT | grep -q Ubuntu; then
        sudo apt-get install ${PACKAGES[*]}
    fi
    if echo $UNAME_OUT | grep -q arch; then
        sudo pacman -S ${PACKAGES[*]}
    fi
    # Copy wallpaper
    mkdir -p $WALLPAPER_DIR
    if [ ! -f "$WALLPAPER_FILE" ]; then
        cp $LOCAL_WALLPAPER_FILE $WALLPAPER_FILE
    fi
    # Copy and install fonts
    mkdir -p $FONTS_DIR
    cp -u $LOCAL_FONTS_DIR/* $FONTS_DIR
    # reload font cache
    fc-cache
    # Stow configs
    stow --dir=config --target=$HOME --restow $CONFIGS
}

function uninstall() {
    # Unstow configs
    stow --dir=config --target=$HOME --delete $CONFIGS
}

function refresh() {
    # Refresh configs
    pkill -USR1 -x sxhkd
    killall -q polybar
    bspc wm -r
}

case $COMMAND in 
    $COMMAND_INSTALL)
        install
        ;;
    $COMMAND_UNINSTALL)
        uninstall
        ;;
    $COMMAND_REFRESH)
        refresh
        ;;
    # TODO add stow
    *)
        echo $BASE_HELP
        ;;
esac
