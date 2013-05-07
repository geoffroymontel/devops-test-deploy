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
  include railsappdb
}

node 'test' {
}
