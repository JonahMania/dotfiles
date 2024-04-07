#!/bin/bash

COMMAND=$1
COMMAND_INSTALL="install"
COMMAND_LINK="link"
COMMAND_UNLINK="unlink"
COMMAND_UNINSTALL="uninstall"
COMMAND_REFRESH="refresh"
BASE_HELP="config [${COMMAND_INSTALL}|${COMMAND_UNINSTALL}|${COMMAND_REFRESH}|${COMMAND_LINK}|${COMMAND_UNLINK}]"
WALLPAPER_DIR="$HOME/.config/wallpaper"
WALLPAPER_FILE="$WALLPAPER_DIR/wallpaper.png"
LOCAL_WALLPAPER_FILE="wallpaper/wallpaper.png"
FONTS_DIR="$HOME/.local/share/fonts"
LOCAL_FONTS_DIR="fonts"
CONFIGS=$(ls config)

PACKAGES=(
    "git"
    "kitty"
    "neofetch"
    "networkmanager"
    "firefox"
    "neovim"
    "stow"
    "hyprland"
    "hyprpaper"
    "ifplugd"
)

function install() {
    # Install packages
    echo "Installing packages..."
    sudo pacman -S ${PACKAGES[*]}

    # TODO Install eww from aur

    # Copy wallpaper
    echo "Installing wallpapers..."
    mkdir -p $WALLPAPER_DIR
    if [ ! -f "$WALLPAPER_FILE" ]; then
        cp $LOCAL_WALLPAPER_FILE $WALLPAPER_FILE
    fi

    # Copy and install fonts
    echo "Installing fonts..."
    mkdir -p $FONTS_DIR
    cp -u $LOCAL_FONTS_DIR/* $FONTS_DIR
    # reload font cache
    fc-cache

    # Stow configs
    echo "Linking configs..."
    stow --dir=config --target=$HOME --restow $CONFIGS
}

function link() {
    stow --dir=config --target=$HOME --restow $1
}

function unlink() {
    stow --dir=config --target=$HOME --delete $1
}

function uninstall() {
    # Unstow configs
    echo "Unlinking configs..."
    stow --dir=config --target=$HOME --delete $CONFIGS
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
    $COMMAND_LINK)
        link $2
        ;;
    $COMMAND_UNLINK)
        unlink $2
        ;;
    *)
        echo $BASE_HELP
        ;;
esac
