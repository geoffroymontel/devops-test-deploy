class puppet {
  package { 'puppet':
    ensure    => latest,
    # require   => Exec['puppet-apt-repo']
  }

  # exec { 'puppet-apt-repo':
  #   command => "wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && dpkg -i puppetlabs-release-precise.deb && apt-get update",
  #   path    => ["/usr/sbin", "/usr/bin", "/sbin", "/bin"],
  #   timeout => 0
  # }
}