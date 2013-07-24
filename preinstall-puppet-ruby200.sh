#!/bin/bash

# WARNING : this script is run as root !

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

# install ruby 2.0
if ! ruby -v | grep 2.0.0 > /dev/null 2>&1; then
  echo "Updating Ubuntu"

  sudo apt-get update -y # update apt sources
  # sudo apt-get upgrade -y # upgrade all packages
  sudo apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev git-core curl libsqlite3-dev -y
  
  sudo rm -rf /opt/vagrant_ruby # uninstalling vagrant ruby

  echo "Installing chruby"

  wget --quiet -O chruby-0.3.6.tar.gz https://github.com/postmodern/chruby/archive/v0.3.6.tar.gz
  tar -xzvf chruby-0.3.6.tar.gz
  cd chruby-0.3.6/
  sudo make install
  cd ..
  rm chruby-0.3.6.tar.gz
  rm -rf chruby-0.3.6

  echo "Installing ruby 2.0.0"

  wget --quiet -O ruby-2.0.0-p247.tar.gz http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
  tar -xzvf ruby-2.0.0-p247.tar.gz
  cd ruby-2.0.0-p247
  ./configure --prefix=/opt/rubies/ruby-2.0.0-p247
  make
  sudo make install
  cd ..
  rm ruby-2.0.0-p247.tar.gz
  rm -rf ruby-2.0.0-p247

  echo "Configuring chruby system wise"

  # setup chruby system wise
  sudo tee -a /etc/profile.d/chruby.sh >/dev/null <<EOF
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.0
EOF

  # reload shell
  source /etc/profile
  source ~/.bashrc
  which ruby
  ruby -v
  echo "Ruby installed"

  echo "System wide default for not generating gem documentation"
  sudo tee -a /opt/rubies/ruby-2.0.0-p247/etc/gemrc >/dev/null <<EOF
install: --no-document
update: --no-document
EOF

fi

# install puppet
if ! which puppet > /dev/null 2>&1 || verlte `puppet --version` 3.0 > /dev/null 2>&1; then
  echo "Installing Puppet"
  wget --quiet http://apt.puppetlabs.com/puppetlabs-release-precise.deb
  sudo dpkg -i puppetlabs-release-precise.deb
  sudo apt-get -y update
  sudo apt-get -y install puppet
  rm puppetlabs-release-precise.deb
  echo "Puppet installed"
fi

# echo "installing puppetlabs-mysql module"
# puppet module install puppetlabs-mysql

echo "Warning : system ruby is 1.8, use chruby ruby-2.0 to switch to ruby 2"
