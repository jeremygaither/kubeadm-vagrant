#!/bin/bash -eux

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    ebtables \
    ethtool \
    docker.io \
    apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq kubelet kubeadm kubectl
