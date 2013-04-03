# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :web do |web_config|
    web_config.vm.customize ["modifyvm", :id, "--name", "web", "--memory", "256"]
    web_config.vm.box = "precise64_with_rvm_ruby193_puppet"
    web_config.vm.host_name = "web"
    web_config.vm.forward_port 80, 4567 # redirect nginx port 80 to port 4567 on host
    web_config.vm.forward_port 22, 2222, :auto => true
    web_config.vm.network :hostonly, "33.33.13.2"
    web_config.vm.share_folder "puppet", "/etc/puppet", "."  
  end

  config.vm.define :app do |app_config|
    app_config.vm.customize ["modifyvm", :id, "--name", "app", "--memory", "256"]
    app_config.vm.box = "precise64_with_rvm_ruby193_puppet"
    app_config.vm.host_name = "app"
    app_config.vm.forward_port 3000, 8000 # redirect rails server port 3000 to port 8000 on host
    app_config.vm.forward_port 22, 2222, :auto => true
    app_config.vm.network :hostonly, "33.33.13.3"
    app_config.vm.share_folder "puppet", "/etc/puppet", "."  
  end

  config.vm.define :db do |db_config|
    db_config.vm.customize ["modifyvm", :id, "--name", "db", "--memory", "256"]
    db_config.vm.box = "precise64_with_rvm_ruby193_puppet"
    db_config.vm.host_name = "db"
    db_config.vm.forward_port 22, 2222, :auto => true
    db_config.vm.network :hostonly, "33.33.13.4"
    db_config.vm.share_folder "puppet", "/etc/puppet", "."  
  end

  config.vm.define :worker do |db_config|
    db_config.vm.customize ["modifyvm", :id, "--name", "worker", "--memory", "256"]
    db_config.vm.box = "precise64_with_rvm_ruby193_puppet"
    db_config.vm.host_name = "worker"
    db_config.vm.forward_port 22, 2222, :auto => true
    db_config.vm.network :hostonly, "33.33.13.5"
    db_config.vm.share_folder "puppet", "/etc/puppet", "."  
  end
end
