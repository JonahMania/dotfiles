# Dotfiles

## Installation
1. Clone this repository into your home directory `git clone https://github.com/JonahMania/dotfiles`
2. Create symlinks with stow. For example to link vim `$ stow vim`

## Troubleshooting
### Can't adjust backlight (permissions error)
1. Create a new udev rule at `/etc/udev/rules.d/backlight.rules` with the following content (replace
    sys path with the correct path to your device)

```
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/amdgpu_bl1/brightness", RUN+="/bin/chmod g+w /sys/class/backlight/amdgpu_bl1/brightness"
```

2. Reboot for changes to take effect
3. Add yourself to the video group with `usermod -a -G video username`
4. Logout and login or reboot for changes to take effect
