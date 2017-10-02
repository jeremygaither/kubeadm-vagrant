# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/xenial64"

    master.vm.network "private_network", ip: "192.168.50.2"

    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    master.vm.provision "shell", path: "scripts/setup-base.sh"
  end

  (1..3).each do |node_number|
    config.vm.define "node#{node_number}" do |node|
      node_address = 10 + node_number
      node.vm.box = "ubuntu/xenial64"

      node.vm.network "private_network", ip: "192.168.50.#{node_address}"

      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
      end

      node.vm.provision "shell", path: "scripts/setup-base.sh"
    end
  end
end
