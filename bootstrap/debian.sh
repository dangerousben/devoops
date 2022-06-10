#!/bin/sh -e

if [ $# -lt 1 ]; then
   echo "Usage: $0 <host>"
   exit 1
fi

host=$1
local_user="ansible"

ssh root@$host /bin/sh -e <<EOF
useradd -m $local_user
mkdir /home/$local_user/.ssh
apt-get update
apt-get -y install sudo
echo -e "%sudo\tALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudo-nopasswd
adduser $local_user sudo
EOF

scp ~/.ssh/id_rsa.pub root@$host:/home/$local_user/.ssh/authorized_keys

ssh root@$host /bin/sh -e <<EOF
chown -R $local_user: /home/$local_user
chmod 0600 /home/$local_user/.ssh/authorized_keys
EOF
