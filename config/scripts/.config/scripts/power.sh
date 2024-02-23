#!/bin/bash

POWER_SUPPLY_DIRECTORY="/sys/class/power_supply"

function has_battery() {
    for power_supply in $POWER_SUPPLY_DIRECTORY/*
    do
        if [ ! -f $power_supply/type ]; then
            continue
        fi

        if grep $power_supply/type -e "Battery" -q; then
            exit 0
        fi
    done
    exit 1
}

function battery_level() {
    battery_level=0
    battery_count=0
    battery_status=""

    for power_supply in $POWER_SUPPLY_DIRECTORY/*
    do
        if [ ! -f $power_supply/type ]; then
            continue
        fi

        if grep $power_supply/type -e "Battery" -q; then
            battery_level=$(($battery_level + $(cat $power_supply/capacity)))
            battery_count=$(($battery_count + 1))
            battery_status=$(cat $power_supply/status)
        fi
    done

    if (($battery_count > 0)); then
        battery_level=$(($battery_level / $battery_count))
        icon="❤"
        if [ "$battery_status" = "Charging" ]; then
            icon="⋆"
        fi

        if (($battery_level > 80)); then
            echo "%{T2}${icon}${icon}${icon}${icon}%{T-}"
        elif (($battery_level > 60)); then
            echo "%{T2}${icon}${icon}${icon}%{F${BAR_POWER_DEPLETED}}${icon}%{F-}%{T-}"
        elif (($battery_level > 40)); then
            echo "%{T2}${icon}${icon}%{F${BAR_POWER_DEPLETED}}${icon}${icon}%{F-}%{T-}"
        elif (($battery_level > 20)); then
            echo "%{T2}${icon}%{F${BAR_POWER_DEPLETED}}${icon}${icon}${icon}%{F-}%{T-}"
        else
            echo "%{T2}%{F${BAR_POWER_DEPLETED}}${icon}${icon}${icon}${icon}%{F-}%{T-}"
        fi

        exit 0
    fi
    exit 1
}

case $1 in
    "has_battery")
        has_battery
    ;;

    "battery_level")
        battery_level
    ;;

    *)
        echo "help"
    ;;
esac
