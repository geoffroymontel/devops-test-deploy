# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :test do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "test"
    vm_config.vm.network :private_network, ip: "33.33.13.30"
    vm_config.vm.synced_folder ".", "/etc/puppet"
    vm_config.vm.network :forwarded_port, guest: 80, host: 4567 # redirect nginx port 80 to port 4567 on host
    config.vm.network :forwarded_port, guest: 22, host: 2250, id: "ssh"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "test"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "install-puppet.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

  config.vm.define :web do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "web"
    vm_config.vm.network :private_network, ip: "33.33.13.2"
    vm_config.vm.synced_folder ".", "/etc/puppet"
    vm_config.vm.network :forwarded_port, guest: 80, host: 4567 # redirect nginx port 80 to port 4567 on host
    config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "web"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "install-puppet.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

  config.vm.define :app1 do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "app1"
    vm_config.vm.network :private_network, ip: "33.33.13.3"
    vm_config.vm.synced_folder ".", "/etc/puppet"
    vm_config.vm.network :forwarded_port, guest: 8000, host: 8000
    config.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "app1"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "install-puppet.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

  config.vm.define :db do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "db"
    vm_config.vm.network :private_network, ip: "33.33.13.4"
    vm_config.vm.synced_folder ".", "/etc/puppet"
    config.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "db"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "install-puppet.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

=begin

=end
end
