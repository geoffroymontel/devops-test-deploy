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
    "/var/www/${app_name}/current",
    "/var/www/${app_name}/shared",
    "/var/www/${app_name}/shared/config"]:
    ensure    => directory,
    require   => User['deployer'],
    owner     => deployer,
    group     => admin,
    mode      => 755
  }

  package { "bundler":
    provider  => gem
  }
}
