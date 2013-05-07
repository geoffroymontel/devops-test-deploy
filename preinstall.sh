#!/bin/bash

# WARNING : this script is run as root !

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

# install ruby 1.9.3
if ! ruby -v | grep 1.9.3 > /dev/null 2>&1; then
  echo "Installing Ruby 1.9.3-p392"
  sudo apt-get update -y
  sudo apt-get install build-essential zlib1g-dev libssl-dev libreadline-dev git-core curl libyaml-dev libsqlite3-dev -y
  sudo rm -rf /opt/vagrant_ruby # uninstalling vagrant ruby
  curl --remote-name http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz
  tar xzf ruby-1.9.3-p392.tar.gz
  cd ruby-1.9.3-p392/
  ./configure
  make
  sudo make install
  cd ..
  rm ruby-1.9.3-p392.tar.gz
  rm -rf ruby-1.9.3-p392
  source ~/.bashrc
  which ruby
  ruby -v
  echo "Ruby installed"
fi

# install puppet
if ! which puppet > /dev/null 2>&1 || verlte `puppet --version` 3.0 > /dev/null 2>&1; then
  echo "Installing Puppet"
  wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
  sudo dpkg -i puppetlabs-release-precise.deb
  sudo apt-get -y update
  sudo apt-get -y install puppet
  rm puppetlabs-release-precise.deb
  echo "Puppet installed"
fi

echo "FYI, /usr/local/bin/ruby is now running ruby 1.9.3"
echo "but Puppet uses ruby 1.8 which is installed in /usr/bin/ruby"

# install modules
# if ! sudo puppet module list | grep puppetlabs-mysql > /dev/null 2>&1; then
#   echo "Installing puppetlabs/postgresql module"
#   puppet module install puppetlabs/postgresql 
#   echo "Installing puppetlabs/mysql module"
#   puppet module install puppetlabs/mysql
# fi
