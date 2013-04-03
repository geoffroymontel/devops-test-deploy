node basenode {
  $web_ip_address = "33.33.13.2"
  $app_ip_address = "33.33.13.3"
  $db_ip_address = "33.33.13.4"
  $worker_ip_address = "33.33.13.5"
  $app_name = "instatube"

  user { 'deployer':
    ensure     => present,
    gid        => 'admin',
    home => '/home/deployer',
    managehome => true,
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
