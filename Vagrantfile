# -*- mode: ruby -*-
# vi: set ft=ruby :

MAX_MASTERS = 1
MAX_MINIONS = 3
DEFAULT_BOX = 'ubuntu/xenial64'.freeze

Vagrant.configure('2') do |config|
  (1..MAX_MASTERS).each do |master_number|
    config.vm.define "master#{master_number}" do |master|
      master.vm.box = DEFAULT_BOX

      master_address = 1 + master_number
      master.vm.network 'private_network', ip: "192.168.50.#{master_address}"

      master.vm.provider 'virtualbox' do |vb|
        vb.memory = '1024'
      end

      master.vm.provision 'shell', path: 'scripts/setup-base.sh'
    end
  end

  (1..MAX_MINIONS).each do |node_number|
    config.vm.define "node#{node_number}" do |node|
      node.vm.box = DEFAULT_BOX

      node_address = 10 + node_number
      node.vm.network 'private_network', ip: "192.168.50.#{node_address}"

      node.vm.provider 'virtualbox' do |vb|
        vb.memory = '1024'
      end

      node.vm.provision 'shell', path: 'scripts/setup-base.sh'
    end
  end
end
