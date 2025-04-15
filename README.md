# Poor Man's Proxmox Watchdog

A bash script working as a helthcheck for a VM. 

Takes in a single argument in form of VMID.

`./watchdog.sh <REPLACE_WITH_VMID>` 

## Requirements
Copy/clone code into your directory 

Add exec permission on watchdog.sh

`chmod u+x /path/to/watchdog.sh`

## What's bck_watchdog
It's for a pretty specific usecase when you have HA opnsense running in 2 vm's. 

If both VM's go down then this would start a third "emergency" VM running OPNSense.

## Examples

`./watchdog.sh 100` 

### Crontab

` 
*/5 * * * * /bin/bash /path/to/watchdog.sh 100
` 

This will check every 5 minutes if a VM us runninig.

### Crontab with bck_watchdog

```
*/5 * * * * /bin/bash /path/to/watchdog.sh 100

*/2 * * * * /bin/bash /path/to/watchdog.sh 1003

*/2 * * * * /bin/bash /path/to/watchdog.sh 1004
```

This will check the HA 2 nodes every 2 minutes and backup one every 5 minutes.

where 1003 and 1004 are main HA nodes and 100 is the backup.