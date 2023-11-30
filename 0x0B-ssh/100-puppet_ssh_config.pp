# configures ssh client

file { '/etc/ssh/ssh_config':
  ensure  => present,
  content => "Host *\
\tIdentityFile ~/.ssh/school\n\
\tPasswordAuthentication no\n",
  owner   => 'root',
  group   => 'root',
  mode    => '0600',
}

