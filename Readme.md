# Playground for automatic deployment

## Goal
The goal is to be able to deploy a Rails app to a cluster of machines consisting of
- 1 Web instance running Nginx
- 2 App instances running Unicorn
- 1 DB instance running Postgresql
- 1 worker instance running Delayed Job

And more to come & test

## Doing a base image with Vagrant

First, you have to make an Ubuntu 12.04TLS image with rvm, ruby, and puppet installed.
I called it `precise64_with_rvm_ruby193_puppet`

* Update Linux
```
sudo apt-get update
sudo apt-get upgrade
```

* Install Git and build-essentials
```
sudo apt-get install build-essential git-core curl
```

* Install RVM
```
curl -L get.rvm.io | bash -s stable
```

Read the output to know how to start using rvm.

Then install what 
```
rvm requirements
```
and 
```
rvm notes
```
say

* Install Ruby
```
rvm install ruby-1.9.3-p392
rvm use 1.9.3 --default
ruby -v
``

* Install Puppet

```
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get install puppet
```

## Starting the instances locally with Vagrant
```bash
vagrant up
```

## Installing the software stack
You have to log in to each instance and run puppet

For instance, to install on the Web instance :

```
vagrant ssh web
cd /vagrant
sudo puppet apply manifests/site.pp
```

and do the same for `app`, `db` and `worker`