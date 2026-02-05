#!/bin/sh
# createuser.sh
#
# Skapar ett konto med angivet user & pass
# Indata från detta script kommer från webbsidan
# För att allt skapa fungera måste filen läggas till i sudoers:
# www-data ALL=NOPASSWD: /root/createuser.sh
# och rättigheter tillagda i /root/.my.cnf;
# [mysql]
# user=root
# password=ROOT-PASSWORD
#
# Christian Ohlsson 2023-04-02
# Version 1.5
# Gruppen ska vara www-data på Debian

if [ "$#" -lt 2 -o "$#" -gt 3 ]; then
 echo "Usage:`basename $0` username password"
    exit 1
fi
grupp="users"
username="$1"
password="$2"
hemkatalog="/home/$username"
#if [ ! -d $hemkatalog ]; then
#    mkdir -p $hemkatalog
#fi
/usr/sbin/useradd  -c "$username" -d "$hemkatalog" -m "$username" -g "$grupp" -s /bin/bash
echo `date "+%F"` "$username" >> "/root/skapade_konton.txt"
echo "$username:$password" | /usr/sbin/chpasswd
chmod 755 "$hemkatalog"
chown root "$hemkatalog"
mkdir "$hemkatalog/public_html"
chmod 700 "$hemkatalog/public_html"
chown "$username":"$grupp" "$hemkatalog/public_html"
echo "CREATE USER $username@localhost IDENTIFIED BY '$password';" | mysql -u root
echo "CREATE DATABASE $username;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON $username.* TO $username@localhost;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
/usr/sbin/setquota -u "$username" 1000M 1020M 0 0 /home

exit 1
