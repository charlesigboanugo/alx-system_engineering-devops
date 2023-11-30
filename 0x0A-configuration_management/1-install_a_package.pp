# install flask

class { 'python':
  version => 'system',
}

exec { 'install_flask':
  command => '/usr/bin/pip3 install Flask',
  path    => ['/usr/bin'],
  unless  => '/usr/bin/pip3 show Flask',
}

