node basenode {
  $web_ip_address = "172.16.0.2"
  $db_ip_address = "172.16.0.3"
  $app_ip_addresses = ["172.16.0.4", "172.16.0.5"]
  $worker_ip_address = "172.16.0.6"
  $subnetwork = "172.16.0.0/24"
  $app_name = "devops-test-app"
  $app_password = "m0nst3rz"

  # define init stage
  stage { 'init': before => Stage['main'] }

  class { 'ubuntu-update':
    stage => 'init'
  }

  class { 'users': 
    stage => 'init',
    require => Class['ubuntu-update']
  }

  include nodejs
  include railsapp
}

node 'web' inherits basenode {
  include nginx
}

node 'app1', 'app2' inherits basenode {
  include unicorn
}

node 'db' inherits basenode {
  class { 'postgresql::server':
    config_hash => {
      'manage_redhat_firewall'     => true,
      'listen_addresses'           => '*',
    }
  }

  postgresql::pg_hba_rule { 'allow application network to access app database':
    description => "Open up postgresql for access from 172.16.0.0/24",
    type => "host",
    database => "${app_name}_production",
    user => "${app_name}",
    address => "$subnetwork",
    auth_method => "trust",
  }

  postgresql::db { "${app_name}_production":
    user     => "${app_name}",
    password => "${app_password}""
  }
}

node 'test' {
}
