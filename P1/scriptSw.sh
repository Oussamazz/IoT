#!/usr/bin/env bash

# Deploy keys to allow all nodes to connect each others as root
mkdir -p /root/.ssh
mv /tmp/id_rsa*  /root/.ssh/

chmod 400 /root/.ssh/id_rsa*
chown root:root  /root/.ssh/id_rsa*

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 400 /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys

# Add current node in  /etc/hosts
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# Add kubemaster1 in  /etc/hosts
echo "192.168.42.110  oelazzouS" >> /etc/hosts

echo "Installing k3s in worker machine"
scp -o StrictHostKeyChecking=no root@oelazzouS:/var/lib/rancher/k3s/server/token /tmp/token
export INSTALL_K3S_VERSION=v1.21.4+k3s1
export INSTALL_K3S_EXEC="agent --server https://oelazzouS:6443 --token-file /tmp/token --node-ip=192.168.42.111"
curl -sfL https://get.k3s.io | sh -

echo "alias kube='kubectl'" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc