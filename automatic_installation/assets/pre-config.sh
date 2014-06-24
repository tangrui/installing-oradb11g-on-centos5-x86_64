#!/bin/bash

# Get hostname variables
OLD_HOSTNAME="$( hostname )"
NEW_HOSTNAME=$1

if [ -z "$NEW_HOSTNAME" ]; then
    echo -n "Please enter hostname [$OLD_HOSTNAME]: "
    read NEW_HOSTNAME < /dev/tty
fi

if [ -z "$NEW_HOSTNAME" ]; then
    NEW_HOSTNAME="$OLD_HOSTNAME"
fi

# Changing hostname
if [ "$OLD_HOSTNAME" != "$NEW_HOSTNAME" ]; then
    echo -n ">>> Changing hostname from $OLD_HOSTNAME to $NEW_HOSTNAME..."
    hostname "$NEW_HOSTNAME"
    sed -i "s/HOSTNAME=.*/HOSTNAME=$NEW_HOSTNAME/g" /etc/sysconfig/network
    if [ -n "$( grep "$OLD_HOSTNAME" /etc/hosts )" ]; then
        sed -i "s/$OLD_HOSTNAME/$NEW_HOSTNAME/g" /etc/hosts
    else
        echo -e "$( hostname -i | awk '{ print $1 }' )\t$NEW_HOSTNAME" >> /etc/hosts
    fi
    echo "Done!"
fi

# Get ip address variables
IP_ADDRESS=$2

if [ -z "$IP_ADDRESS" ]; then
    IP_ADDRESS="$( ifconfig | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{print $1}' )"
fi

echo -n "Please enter ip address [$IP_ADDRESS]: "
read IP_ADDRESS_INPUT < /dev/tty

# Make ip address resolve to the new hostname
function change_hosts {
    echo -n ">>> Making ip address resolve to the new hostname..."
    echo -e "$IP_ADDRESS\t$NEW_HOSTNAME\t$( hostname -s )" >> /etc/hosts
    echo "Done!"
}

if [ -z "$IP_ADDRESS_INPUT" ]; then
    if [ -z "$( grep "$IP_ADDRESS" /etc/hosts )" ]; then
        change_hosts
    fi
else
    if [ "$IP_ADDRESS_INPUT" != "$IP_ADDRESS" ]; then
        IP_ADDRESS="$IP_ADDRESS_INPUT"
        change_hosts
    fi
fi

# Restart network service
echo ">>> Restarting network..."
/etc/init.d/network restart
echo "Done!"

# Make system up to date
echo ">>> Updating system..."
yum update -y
echo "Done!"

# Add oracle public yum server
echo ">>> Adding oracle public yum server..."
wget https://public-yum.oracle.com/public-yum-el5.repo -O /etc/yum.repos.d/public-yum-el5.repo --no-check-certificate
echo "Done!"

# Add PGP key
echo ">>> Adding PGP key..."
wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-el5 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle --no-check-certificate
echo "Done!"

# Install oracle-validated RPMs
echo ">>> Installing oracle-valicated RPMs..."
yum install oracle-validated -y
echo "Done!"

# Clean up
echo -n ">>> Cleaning up..."
rm /etc/yum.repos.d/public-yum-el5.repo
rm /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
echo "Done!"

# Install other dependencies
echo ">>> Installing other dependencies..."
yum install unixODBC-2.2.11 -y
yum install pdksh-5.2.14 -y
echo "Done!"

# Create oracle directories
echo -n ">>> Creating oracle installation directories..."
mkdir -p /u01/app/oracle/
mkdir /u01/oradata/
mkdir /u01/fast_recovery_area/

chown -R oracle:oinstall /u01/
chmod -R 755 /u01/
echo "Done!"

# Set oracle account password
echo ">>> Setting oracle account password..."
echo 'oracle' | passwd oracle --stdin
echo "Done!"

# Append oracle account's .bash_profile
echo -n ">>> Appending oracle account's .bash_profile..."
cat >> /home/oracle/.bash_profile << EOF

# Oracle settings
umask 022

TMP=/tmp; export TMP
TMPDIR=/tmp; export TMPDIR

EOF
echo "Done!"
