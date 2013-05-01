class users {
  user { 'deployer':
    ensure      => present,
    gid         => 'admin',
    home        => '/home/deployer',
    managehome  => true,
    shell       => '/bin/bash'
  }  

  ssh_authorized_key { 'geoffroy':
    ensure      => present,
    user        => 'deployer',
    key         => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDWQgKrdJYmlBeq2usjuT36SpQFHfTu4BZDU87t47VKIYm0YqEVNYan+TZt8wWqTELnzn3LbssCKIBX+1Uk3lnX4ytl1DLk3nVpWYtgJXXxRHIOrz5UHiBuHhC0h1N6K/WXnNOM9HausBDcnnOS0RKycWNhCfOiYUV/iKeG72uBAzedajc3uSxtW59B2YmtDLXbfms/YSt6RdWYQZnGaidrGH64GB+Blall3aZx6io7Ww7bw1tZE+5PKCai8pQnqIfdjnp7OEntl2ySZuD3iGtBl/5vdBIAYHwOSDElPXvjFEbHgZTxIT2FxFRxBB8gzGEXAWY7XUk+jN+Lz/IvqAJH',
    type        => 'ssh-rsa'
  }
}