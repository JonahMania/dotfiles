#!/bin/bash

if nmcli --get-values NAME connection show --active | grep -q ethernet ; then
    echo "Wired"
else
    nmcli --get-values NAME connection show --active
fi
