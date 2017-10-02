# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'securerandom'

MAX_MASTERS = 1
MAX_MINIONS = 1
DEFAULT_BOX = 'ubuntu/xenial64'.freeze

random_string1 = SecureRandom.hex
random_string2 = SecureRandom.hex
cluster_init_token = "#{random_string1[0..5]}.#{random_string2[0..15]}"

first_master = nil

Vagrant.configure('2') do |config|
  (1..MAX_MASTERS).each do |master_number|
    master_name = "master#{master_number}"
    config.vm.define master_name do |master|
      master.vm.box = DEFAULT_BOX

      master_address = 1 + master_number
      master_ip = "192.168.50.#{master_address}"
      first_master = master_ip if first_master.nil?
      master.vm.network 'private_network', ip: master_ip

      master.vm.provider 'virtualbox' do |vb|
        vb.memory = '1024'
      end

      master.vm.provision 'shell', inline: "echo 127.0.0.1 #{master_name} >>/etc/hosts"
      master.vm.provision 'shell', inline: "echo #{master_name} >/etc/hostname"
      master.vm.provision 'shell', inline: "hostname #{master_name}"

      master.vm.provision 'shell', path: 'scripts/setup-base.sh'

      master.vm.provision 'shell' do |s|
        s.args = [master_ip]
        s.path = 'scripts/setup-master.sh'
      end

      master.vm.provision 'shell', inline: "kubeadm token create #{cluster_init_token}"
    end
  end

  (1..MAX_MINIONS).each do |node_number|
    node_name = "node#{node_number}"
    config.vm.define node_name do |node|
      node.vm.box = DEFAULT_BOX

      node_address = 10 + node_number
      node.vm.network 'private_network', ip: "192.168.50.#{node_address}"

      node.vm.provider 'virtualbox' do |vb|
        vb.memory = '1024'
      end

      node.vm.provision 'shell', inline: "echo 127.0.0.1 #{node_name} >>/etc/hosts"
      node.vm.provision 'shell', inline: "echo #{node_name} >/etc/hostname"
      node.vm.provision 'shell', inline: "hostname #{node_name}"

      node.vm.provision 'shell', path: 'scripts/setup-base.sh'

      node.vm.provision 'shell', inline: "kubeadm join --token #{cluster_init_token} #{first_master}:6443"
    end
  end
end
