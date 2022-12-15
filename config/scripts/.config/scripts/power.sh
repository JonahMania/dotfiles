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
    for power_supply in $POWER_SUPPLY_DIRECTORY/*
    do
        if [ ! -f $power_supply/type ]; then
            continue
        fi

        if grep $power_supply/type -e "Battery" -q; then
            battery_level=$(($battery_level + $(cat $power_supply/capacity)))
            battery_count=$(($battery_count + 1))
        fi
    done

    if (($battery_count > 0)); then
        battery_level=$(($battery_level / $battery_count))

        if (($battery_level > 80)); then
            echo "%{T2}❤❤❤❤%{T-}"
        elif (($battery_level > 60)); then
            echo "%{T2}❤❤❤%{F${BAR_POWER_DEPLETED}}❤%{F-}%{T-}"
        elif (($battery_level > 40)); then
            echo "%{T2}❤❤%{F${BAR_POWER_DEPLETED}}❤❤%{F-}%{T-}"
        elif (($battery_level > 20)); then
            echo "%{T2}❤%{F${BAR_POWER_DEPLETED}}❤❤❤%{F-}%{T-}"
        else
            echo "%{T2}%{F${BAR_POWER_DEPLETED}}❤❤❤❤%{F-}%{T-}"
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
