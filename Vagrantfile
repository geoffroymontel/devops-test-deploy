# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :web do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "web"
    vm_config.vm.network :forwarded_port, host: 4567, guest: 80 # redirect nginx port 80 to port 4567 on host
    vm_config.vm.network :private_network, ip: "33.33.13.2"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "web"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

=begin
  config.vm.define :app do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "app"
    vm_config.vm.network :forwarded_port, host: 8000, guest: 3000 # redirect rails server port 3000 to port 8000 on host
    vm_config.vm.network :private_network, ip: "33.33.13.3"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "app"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.define :db do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "db"
    vm_config.vm.network :private_network, ip: "33.33.13.4"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "db"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.define :worker do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "worker"
    vm_config.vm.network :private_network, ip: "33.33.13.5"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "worker"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end
=end
end
