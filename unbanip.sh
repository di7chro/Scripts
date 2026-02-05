#!/bin/sh
# unbanip.sh
# Tar bort en fail2ban på viss IP-adress
# Crille 2015-10-27
if [ "$#" -lt 1 -o "$#" -gt 2 ]; then
        echo "Usage:`basename $0` <ip-adress>"
        exit 1
fi
adress="$1"
sudo fail2ban-client set sshd unbanip $adress
