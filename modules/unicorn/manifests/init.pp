class unicorn {
  require railsapp

  package { 'unicorn':
    ensure    => installed,
    provider  => gem,
  }

  service { "unicorn_${app_name}":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    start     => "/etc/init.d/unicorn_${app_name} start",
    stop      => "/etc/init.d/unicorn_${app_name} stop",
    restart   => "/etc/init.d/unicorn_${app_name} reload",
    require   => [
      File["unicorn_${app_name}.rb"],
      File["init_d_${app_name}"]
    ],
    subscribe => [
      File["unicorn_${app_name}.rb"],
      File["init_d_${app_name}"]
    ]
  }

  # unicorn application specific configuration -> stored in app directory
  file { "unicorn_${app_name}.rb":
    path      => "/var/www/${app_name}/shared/config/unicorn.rb",
    ensure    => file,
    require   => Package['unicorn'],
    content   => template("unicorn/unicorn.rb.erb"),
    owner     => deployer,
    group     => admin,
  }

  # init.sh to start unicorn, stored in app directory
  file { "unicorn_${app_name}.sh":
    path      => "/var/www/${app_name}/shared/config/unicorn.sh",
    ensure    => file,
    require   => Package['unicorn'],
    content   => template("unicorn/unicorn.sh.erb"),
    owner     => deployer,
    group     => admin,
    mode      => 755
  }

  # symlink to init.d to start as a service
  file { "init_d_${app_name}":
    path      => "/etc/init.d/unicorn_${app_name}",
    ensure    => 'link',
    target    => "/var/www/${app_name}/shared/config/unicorn.sh",
    require   => File["unicorn_${app_name}.sh"]
  }
}