# configures ssh client

file { '/home/your_username/.ssh/config':
  ensure  => present,
  content => "Host example.com\n\
\tIdentityFile ~/.ssh/school\n\
\tPasswordAuthentication no\n",
  owner   => 'your_username',
  group   => 'your_username',
  mode    => '0600',
}

