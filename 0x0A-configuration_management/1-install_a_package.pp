# installs flask

class { 'python':
  version => 'system',
}

exec { '1-install_a_package.pp':
  command => '/usr/bin/pip3 install Flask==2.1.0',
  path    => ['/usr/bin'],
  unless  => '/usr/bin/pip3 show Flask | grep -q "Version: 2.1.0"',
}
