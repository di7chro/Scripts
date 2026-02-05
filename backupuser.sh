#!/bin/sh
# backupuser.sh
#
# Backupar ett konto med angivet username
# Skapar backup av användarens databas och placerar i användarens
# hemkatalog före denna taras och placeras under /home
# Scriptet behöver root till mysql och mysqldump angivet
# i /root/.my.cnf
# [mysql] samt [mysqldump]
# user=root
# password=ROOT-PASSWORD
#
# Christian Ohlsson 2025-02-11
# Version 1.3
# Gruppen ska vara www-data på Debian

if [ "$#" -lt 1 -o "$#" -gt 2 ]; then
 echo "Usage: `basename $0` username"
    exit 1
fi
username="$1"
hemkatalog="/home/$username"

echo "Skapar en backup av kontot: $hemkatalog"
mysqldump $username > "$hemkatalog/databasbackup_$username.sql"
tar cvzf "/home/backup_$username.tgz" "$hemkatalog"
chmod 644 "/home/backup_$username.tgz"

echo "Allt klart!"
echo "En backup av kontot finns på /home/backup_$username.tgz"
exit 1
