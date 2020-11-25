#!/bin/bash

set -eux

sudo -i
yum install -y nfs-utils

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable rpc-statd
systemctl enable nfs-idmapd

systemctl start rpcbind
systemctl start nfs-server
systemctl start rpc-statd
systemctl start nfs-idmapd

mkdir -p /export/shared
chmod 0777 /export/shared

echo "/export/shared  192.168.10.0/24(rw,async)" >> /etc/exports

exportfs -ra
cat /var/lib/nfs/etab

systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld

firewall-cmd --get-services
firewall-cmd --permanent --add-service=nfs3
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
firewall-cmd --list-all






