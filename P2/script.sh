#!/usr/bin/env bash

# Add current node in  /etc/hosts
echo "127.0.1.1 $(hostname)" >> /etc/hosts

echo "Installing k3s..."
export INSTALL_K3S_VERSION=v1.21.4+k3s1
export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip=192.168.42.110"
curl -sfL https://get.k3s.io | sh -

echo "alias k='kubectl'" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc

mv /tmp/deploy.yaml /home/vagrant
mv /tmp/app1 /home/vagrant
mv /tmp/app2 /home/vagrant
mv /tmp/app3 /home/vagrant

/usr/local/bin/kubectl create configmap app-one-html --from-file /home/vagrant/app1/index.html
/usr/local/bin/kubectl create configmap app-two-html --from-file /home/vagrant/app2/index.html
/usr/local/bin/kubectl create configmap app-three-html --from-file /home/vagrant/app3/index.html

/usr/local/bin/kubectl apply -f /home/vagrant/deploy.yaml