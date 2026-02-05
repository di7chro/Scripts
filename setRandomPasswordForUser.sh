#!/bin/sh
# setRandomPasswordForUser.sh
#
# Sätter ett slumpat lösenor på en viss användare
#
# Christian Ohlsson 2021-12-01
# Version 1.1
# Gruppen ska vara www-data på Debian

if [ "$#" -lt 1 -o "$#" -gt 2 ]; then
 echo "Usage:`basename $0` username"
    exit 1
fi
username="$1"
password=`</dev/urandom tr -dc A-Za-z0-9 | head -c10`
echo "$username:$password" | /usr/sbin/chpasswd
echo "ALTER USER '$username'@'localhost' IDENTIFIED BY '$password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "Bytade lösenord. De nya inloggningsuppgifterna är:"
echo "Username: $username"
echo "Password: $password"
exit 1
