#!/bin/bash

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

# install puppet
if verlte `puppet --version` 3.0 ; then
  echo "Installing Puppet"
  wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
  sudo dpkg -i puppetlabs-release-precise.deb
  sudo apt-get -y update
  sudo apt-get -y install puppet
  rm puppetlabs-release-precise.deb
  echo "Puppet installed"
fi

# install module postgresql
if ! sudo puppet module list | grep puppetlabs-postgresql > /dev/null 2>&1; then
  echo "Installing puppetlabs/postgresql module"
  puppet module install puppetlabs/postgresql 
fi
