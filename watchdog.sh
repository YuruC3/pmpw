#!/bin/bash

# check if $1 exists

if [[ -z $1 ]]
then
    echo "Pass a VMID."
    exit 1
fi

#------------------------------------------------
# CONSTS
VMID="$1"
QMSTAT="$(/usr/sbin/qm status $VMID )" > /dev/nul> /dev/null0

#------------------------------------------------ 
# CODE

# check if container exists
if  echo $QMSTAT | grep  "not exist" 
then
    printf "\nNo such VM!\n"
    exit 1
fi


VMSTATE=$(echo "$QMSTAT" | awk '{print $2}')
#echo $VMSTATE

case $VMSTATE in

    "running")
        #printf "VM %s" "$VMID" "allready running."
        #echo ""
        exit 0
    ;;

    "stopped")
        printf "\nStarting VM %s" "$VMID\n"
        #echo ""  # To lazy to fix output spacing 
        /usr/sbin/qm start "$VMID"
        exit 1

    ;;

    *)
        printf "\nUnknown state\n"
        exit 1
    ;;

esac

# If you have gotify or something simmilar you can paste it under "running") 
# and under "stopped") for notifications.
