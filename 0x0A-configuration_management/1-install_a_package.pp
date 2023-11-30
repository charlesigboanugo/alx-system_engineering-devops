# 1-install_a_package.pp

class { 'python':
  version => 'system',
}

class { 'python::pip':
  ensure  => 'present',
  before  => Package['flask'],
  require => Class['python'],
}

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip',
  require  => Class['python::pip'],
}

exec { 'install_werkzeug':
  command => '/usr/bin/pip3 install Werkzeug==2.1.1',
  path    => ['/usr/bin'],
  unless  => '/usr/bin/pip3 show Werkzeug | grep -q "Version: 2.1.1"',
  require => Package['flask'],
}

