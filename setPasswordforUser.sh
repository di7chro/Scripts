#!/bin/sh
# setPasswordforUser.sh
#
# Sätter ett lösenord på ett konto
#
# Christian Ohlsson 2025-09-21
# Version 1.4

if [ "$#" -lt 1 -o "$#" -gt 2 ]; then
 echo "Usage:`basename $0` username"
    exit 1
fi
username="$1"

# Ask for password, twice
echo -n "Enter new password: ";
stty_orig=`stty -g` # save original terminal setting.
stty -echo          # turn-off echoing.
read password1      # read the password

echo -n "\nAnd again for confirmation: ";
read password2      # read the password
stty $stty_orig     # restore terminal setting.
echo "";                        # Force a newline

# Check weather the password was enterred correctly
if [ "$password1" = "$password2" ]; then
        echo "$username:$password1" | /usr/sbin/chpasswd
        echo "ALTER USER '$username'@'localhost' IDENTIFIED BY '$password';" | mysql -u root
        echo "FLUSH PRIVILEGES;" | mysql -u root
        echo "Password changed for user: $username";
else
        echo "ERROR! Password mismatch. Enter your password twice.";
fi
exit 1
