# Playground for automatic deployment

## Goal
The goal is to be able to deploy a Rails app to a cluster of machines consisting of
- 1 Web instance running Nginx
- 2 App instances running Unicorn
- 1 DB instance running Postgresql
- 1 worker instance running Delayed Job

And more to come & test

## Prerequisites
* Install Virtualbox
* Install Vagrant

## Doing a base image with Vagrant

First, you have to make an Ubuntu 12.04TLS image with ruby 1.9.3 and puppet 3.1 installed.
To do that :

1. download a Ubuntu 12.04 TLS (Precise) box
```bash
vagrant box add lucid64 http://files.vagrantup.com/precise64.box
```

2. Create your own base box. Basebox is a Precise64 box provisionned with `preinstall.sh`

```bash
vagrant up basebox
vagrant package basebox
vagrant box add precise64_ruby_puppet package.box
vagrant destroy basebox
rm package.box
```

It will speed up the other virtual machines setup.

3. Add your SSH public key to users/manifests/init.pp

```ruby
  ssh_authorized_key { 'yourname':
    ensure      => present,
    user        => 'deployer',
    key         => 'your key without the email address at the end nor the ssh-rsa at the beginning',
    type        => 'ssh-rsa'
  }
```

