class railsappdb {
  class { 'mysql::server':
    config_hash => { 
      'root_password' => "$mysql_root_password",
      'bind_address' => '0.0.0.0' 
    }
  }

  mysql::db { "${app_name}_production":
    user     => "${app_name}",
    password => "${app_password}",
    host     => '%',
    grant    => ['all'],
    sql      => "/tmp/improve_security.sql",
    enforce_sql => true,
    require  => File["improve_security.sql"],
  }

  file { 'improve_security.sql':
    path      => '/tmp/improve_security.sql',
    ensure    => file,
    source    => "puppet:///modules/railsappdb/improve_security.sql",
    owner     => deployer,
    group     => admin
  }
}  
