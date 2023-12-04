# installs flask from pip3

package { 'pip3':
  ensure => installed
}
exec { 'install flask':
  command => '/usr/bin/pip3 install flask',
  require => Package('pip3')
}
