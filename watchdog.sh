#!/bin/bash

# check if $1 exists

if [[ -z $1 ]]
then
    echo "Pass a VMID."
    exit 1
fi

#------------------------------------------------
# CONSTS
QMLIST="$(qm list | tail -n +2)"
VMID=$1

#------------------------------------------------ 
# CODE

# check if container exists
if ! echo "$QMLIST" | grep -q " $VMID " 
then
    printf "\nNo such VM!\n"
    exit 1
fi

VMSTATE=$(echo "$QMLIST" | grep " $VMID " | awk '{print $3}')

case $VMSTATE in

    "running")
        printf "VM %s" "$VMID" "allready running."
        echo ""
        exit 0
    ;;

    "stopped")
        printf "Starting VM %s" "$VMID""."
        echo ""  # To lazy to fix output spacing 
        qm start "$VMID"
        exit 0

    ;;

    *)
        printf "\nUnknown state\n"
        exit 1
    ;;

esac

# If you have gotify or something simmilar you can paste it under "running") 
# and under "stopped") for notifications.