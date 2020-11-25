#!/bin/bash

set -eux

#echo "Mount NFSv3 UDP"
#sudo mount.nfs -vv 192.168.10.10:/export/shared /mnt -o nfsvers=3,proto=udp,soft
#mount | grep nfs
#sudo umount /mnt

#echo "Test mount NFSv4"
#sudo mount 192.168.10.10:/export/shared /mnt
#mount | grep nfs
#sudo umount /mnt

sudo -i
yum install -y nfs-utils autofs

systemctl enable firewalld
systemctl start firewalld

systemctl enable autofs
systemctl start autofs

echo "/mnt    /etc/auto.misc" >> /etc/auto.master
echo "share		-rw,soft,intr		192.168.10.10:/export/shared" >> /etc/auto.misc
systemctl restart autofs

mkdir /mnt/share/upload

ls -l /mnt/share
