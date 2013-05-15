# create rails application directory structure
# needed for nginx and unicorn configuration files
# app_name
# |- current
# |- shared
#    |- config

class railsapp {
  file {
    ["/var/www",
    "/var/www/${app_name}",
    "/var/www/${app_name}/shared",
    "/var/www/${app_name}/shared/config"]:
    ensure    => directory,
    owner     => deployer,
    group     => admin,
    mode      => 755
  }

  package { "bundler":
    provider  => gem,
    ensure    => latest
  }

  # postgresql client library
  # package { 'libpq-dev':
  #   ensure  => installed
  # }

  # mysql client library
  package { 'mysql-client':
    ensure => installed
  }

  package { 'libmysqlclient-dev':
    ensure => installed
  }

  file {
    "/var/www/${app_name}/shared/config/database.yml":
    ensure  => present,
    owner   => deployer,
    group   => admin,
    mode    => 600,
    content => template("railsapp/database.yml.erb"),
  }
}
