# installs flask from pip3
exec { 'flask':
  ensure  => '2.1.0',
  require => 'pip3'
}
