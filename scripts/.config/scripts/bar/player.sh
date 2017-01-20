INFO=$(mocp -i)
STATE=$( echo "${INFO}" | grep "State:" | sed "s/State: //g" )

# If nothing is player dont display anything
if [ "${STATE}" = "STOP" ]; then
    exit
fi 

case "${1}" in
    "title" )
        ARTIST=$( echo "${INFO}" | grep "Artist:" | sed "s/Artist: //g" )
        SONG=$( echo "${INFO}" | grep "SongTitle:" | sed "s/SongTitle: //g" )
        if [ "${BLOCK_BUTTON}" != "" ]; then 
            mocp --toggle-pause
        fi
        if [ "${STATE}" != "PLAY" ]; then
            echo " ${ARTIST} - ${SONG} " 
        else
            echo " ${ARTIST} - ${SONG} "  
        fi;;
        # Remove if and uncomment to get rid of play pause buttone in title 
        #echo "  ${ARTIST} - ${SONG}";;
    "play" )
        if [ "${BLOCK_BUTTON}" != "" ]; then 
            mocp --toggle-pause
        fi
        if [ "${STATE}" != "PLAY" ]; then
            echo 
        else
            echo    
        fi;;
    "previous" )   
        if [ "${BLOCK_BUTTON}" != "" ]; then 
            mocp --previous
        fi
        echo ;;
    "next" )   
        if [ "${BLOCK_BUTTON}" != "" ]; then 
            mocp --next
        fi
        echo ;;
esac


