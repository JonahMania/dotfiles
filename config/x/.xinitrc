#!/bin/bash

# Disable x screen saver
xset s off
xset -dpms

# Set capslock to ctrl
setxkbmap -option ctrl:nocaps

exec bspwm
