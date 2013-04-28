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

node "web" inherits basenode {
  include railsapp
  include nginx
}

node "app" inherits basenode {
  include railsapp
  include nodejs
  include unicorn
}

node "db" inherits basenode {
#  include postgresql
}
