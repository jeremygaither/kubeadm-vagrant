#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -yq \
    ebtables \
    ethtool \
    docker.io \
    apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -yq kubeadm
