#!/bin/bash

if nmcli --get-values TYPE connection | grep -q ethernet ; then
    echo "Wired"
else
    nmcli --get-values NAME connection
fi
