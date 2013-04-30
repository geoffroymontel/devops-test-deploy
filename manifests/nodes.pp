node basenode {
  $web_ip_address = "33.33.13.2"
  $app_ip_address = "33.33.13.3"
  $db_ip_address = "33.33.13.4"
  $worker_ip_address = "33.33.13.5"
  $app_name = "devops-test-app"

  # define init stage
  stage { 'init': before => Stage['main'] }

  class { 'ubuntu-update':
    stage => 'init'
  }

  class { 'users': 
    stage => 'init',
    require => Class['ubuntu-update']
  }

  class { 'ruby': 
    version => '1.9.3-p392',
    stage   => 'init',
    require => Class['users']
  }
}

node 'web' inherits basenode {
  include railsapp
  include nginx
}

node 'app1', 'app2' inherits basenode {
  include railsapp
  include nodejs
  include unicorn
}

node 'db' inherits basenode {
  include railsapp
}

node 'test' {
  # define init stage
  stage { 'init': before => Stage['main'] }

  class { 'ubuntu-update':
    stage => 'init'
  }

  class { 'users': 
    stage => 'init',
    require => Class['ubuntu-update']
  }
  
  class { 'postgresql::server':
    config_hash => {
      'manage_redhat_firewall'     => true,
      'listen_addresses'           => '*',
    }
  }

  postgresql::pg_hba_rule { 'allow application network to access app database':
    description => "Open up postgresql for access from 33.33.13.0/24",
    type => 'host',
    database => 'devops-test-app_production',
    user => 'devops-test-app',
    address => '33.33.13.0/24',
    auth_method => 'trust',
  }

  postgresql::db { 'devops-test-app_production':
    user     => 'devops-test-app',
    password => 'password'
  }
}
