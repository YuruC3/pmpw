#!/bin/bash

ORIGINGW=<VM_ID>
GW1=<VM_ID>
GW2=<VM_ID>

# check if $ORIGINGW exists

if [[ -z $ORIGINGW ]]
then
    echo "Pass a VMID."
    exit 1
fi

#------------------------------------------------
# CONSTS
VMID="$1"
QMSTAT="$(/usr/sbin/qm status $ORIGINGW )" > /dev/null

#------------------------------------------------ 
# CODE

# check if container exists
if  echo $QMSTAT | grep  "not exist" 
then
    printf "\nNo such VM!\n"
    exit 1
fi


#VMSTATE=$(echo "$QMSTAT" | awk '{print $2}')
#echo $VMSTATE

if [[ $(/bin/bash /root/./vm_check.sh $GW1) == 1 ]] && [[ $(/bin/bash /root/./vm_check.sh $GW2) == 1 ]]
then
	#/usr/sbin/qm start "$VMID"
	echo "EMERGENCY START OF ORIGINAL GATEWAY"
	exit 0
fi
