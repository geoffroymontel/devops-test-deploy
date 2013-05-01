# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :web do |vm_config|
    vm_config.vm.box = 'precise64_ruby_puppet'
    vm_config.vm.hostname = "web"
    vm_config.vm.network :private_network, ip: "172.16.0.2"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "web"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "preinstall.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

  config.vm.define :db do |vm_config|
    vm_config.vm.box = 'precise64_ruby_puppet'
    vm_config.vm.hostname = "db"
    vm_config.vm.network :private_network, ip: "172.16.0.3"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "db"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "preinstall.sh"

    vm_config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
    end
  end

  (1..2).each do |i|
    config.vm.define "app#{i}".to_sym do |vm_config|
      vm_config.vm.box = 'precise64_ruby_puppet'
      vm_config.vm.hostname = "app#{i}"
      vm_config.vm.network :private_network, ip: "172.16.0."+(3+i).to_s
      vm_config.vm.synced_folder ".", "/etc/puppet"

      vm_config.vm.provider "virtualbox" do |v|
        v.name = "app#{i}"
        v.customize ["modifyvm", :id, "--memory", "256"]
      end

      vm_config.vm.provision :shell, :path => "preinstall.sh"

      vm_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "site.pp"
      end
    end
  end

  config.vm.define :basebox do |vm_config|
    vm_config.vm.box = 'precise64'
    vm_config.vm.hostname = "basebox"
    vm_config.vm.synced_folder ".", "/etc/puppet"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "basebox"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end

    vm_config.vm.provision :shell, :path => "preinstall.sh"
  end

=begin
  config.vm.define :test do |vm_config|
    vm_config.vm.box = 'precise64_ruby_puppet'
    vm_config.vm.hostname = "test"
    vm_config.vm.network :private_network, ip: "172.16.0.30"
    vm_config.vm.synced_folder ".", "/etc/puppet"
    vm_config.vm.network :forwarded_port, guest: 80, host: 4567 # redirect nginx port 80 to port 4567 on host
    config.vm.network :forwarded_port, guest: 22, host: 2250, id: "ssh"

    vm_config.vm.provider "virtualbox" do |v|
      v.name = "test"
      v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end
=end
end
