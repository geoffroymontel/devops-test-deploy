class nginx {
  require railsapp

  package { 'nginx':
    ensure    => installed,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [File['nginx.conf'], File['app.conf']]
  }

  # remove default nginx file
  file { 'default':
    path      => '/etc/nginx/sites-enabled/default',
    ensure    => absent
  }

  # nginx non application specific configuration
  file { 'nginx.conf':
    path      => '/etc/nginx/nginx.conf',
    ensure    => file,
    require   => Package['nginx'],
    source    => "puppet:///modules/nginx/nginx.conf",
    owner     => deployer,
    group     => admin,
  }

  # nginx application specific configuration -> stored in app directory
  file { 'app.conf':
    path      => "/var/www/${app_name}/shared/config/nginx.conf",
    ensure    => file,
    require   => Package['nginx'],
    content   => template("nginx/app.conf.erb"),
    owner     => deployer,
    group     => admin,
  }

  # symlink from nginx sites-enabled to the application directory
  file { "/etc/nginx/sites-enabled/${app_name}":
     ensure   => 'link',
     target   => "/var/www/${app_name}/shared/config/nginx.conf",
     require  => File['app.conf']
  }
}
