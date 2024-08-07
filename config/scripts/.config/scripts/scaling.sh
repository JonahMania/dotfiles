DISPLAY_RESOLUTION=$(xrandr | grep "*" | grep -o '[0-9]*x[0-9]*')

case $DISPLAY_RESOLUTION in
    3840x2160)
        # Bar
        export BAR_HEIGHT="48px"
        export BAR_WORKSPACE_PADDING="8px"
        export BAR_TEXT_FONT="Iosevka Term:size=13;2"
        export BAR_ICON_FONT="Iosevka Term:size=32:weight=light;7"
        
        # Windows
        export WINDOW_BORDER_WIDTH=4 # [px]
        export WINDOW_GAP=24 # [px]
    ;;

    *)
        # Bar
        export BAR_HEIGHT="38px"
        export BAR_WORKSPACE_PADDING="6px"
        export BAR_TEXT_FONT="Iosevka Term:size=12;2"
        export BAR_ICON_FONT="Iosevka Term:size=26:weight=light;6"

        # Windows
        export WINDOW_BORDER_WIDTH=2 # [px]
        export WINDOW_GAP=12 # [px]
    ;;
esac
