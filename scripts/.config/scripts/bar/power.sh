BAT0SIZE=$( cat /sys/class/power_supply/BAT0/energy_full )
BAT1SIZE=$( cat /sys/class/power_supply/BAT1/energy_full )
BAT0CURR=$( cat /sys/class/power_supply/BAT0/energy_now )
BAT1CURR=$( cat /sys/class/power_supply/BAT1/energy_now )

TOTALSIZE=$(( BAT0SIZE + BAT1SIZE )) 
TOTALCURR=$(( BAT0CURR + BAT1CURR )) 
PERCENT=$(echo "scale=2; $TOTALCURR / $TOTALSIZE" | bc)
PERCENT=$(echo "${PERCENT//./}")
STATUS=$(cat /sys/class/power_supply/BAT1/status)
#Battery 0
ICON=

if [ "$STATUS" == "Charging" ]; then
    #Charging
    ICON=
elif [ "$PERCENT" > 19 ]; then
    #Battery 1
    ICON=
elif [ "$PERCENT" > 39 ]; then
    #Battery 2
    ICON=
elif [ "$PECENT" > 59 ]; then
    #Battery 3
    ICON=
else
    #Battery 4
    ICON=
fi



echo "${ICON} ${PERCENT}%"
