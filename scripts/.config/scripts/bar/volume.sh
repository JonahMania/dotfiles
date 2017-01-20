# If the button is clicked mute or unmute master volume
if [ "${BLOCK_BUTTON}" != "" ]; then
    amixer set Master toggle > /dev/null
fi

INFO=$(amixer get Master)
VOLUME=$( echo "${INFO}" | grep "Mono:" | sed "s/^[^/[]*\[//g" | sed "s/].*//g" )
AUDIO=$( echo "${INFO}" | grep "Mono:" | sed "s/^.*\[.*\[.*\[//g" | sed "s/].*//g" )

if [ "${AUDIO}" = "on" ]; then
    echo " ${VOLUME}"
else
    echo " ${VOLUME}"
fi

