# configures Nginx server on my new ubuntu machine
# adds http response header to the server

service {'nginx':
  ensure    => 'running',
  enable    => 'true',
  require   => Package['nginx'],
  subscribe => File['/etc/nginx/sites-available/default']
}

package { 'nginx':
  provider => 'apt',
  before   => File['/etc/nginx/sites-available/default']
}
file { '/usr/share/nginx/html/index.html':
  ensure  => 'file',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => "Hello World!\n",
  require => Package['nginx']
}
file { '/usr/share/nginx/html/404.html':
  ensure  => 'file',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => "Ceci n\'est pas une page\n",
  require => Package['nginx']
}
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  mode    => '0744',
  owner   => 'root',
  group   => 'root',
  content => inline_template("server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!

        # include snippets/snakeoil.conf;
                                                                                          root /usr/share/nginx/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        # Add custom 404 page                                                     
        error_page 404 /404.html;                                                 
        # Apply custom header globally for all locations

        add_header X-Served-By <%= `/usr/bin/uname -n` %>;

        location = /404.html {
                internal;
        }

        # Add redirect for /redirect_me

        location /redirect_me {
                rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
        }

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri \$uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        #location ~ .php$ {
        #       include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
        #       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        #}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	#
	#location ~ /.ht {
        #       deny all;
}


# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
#server {
#       listen 80;
#       listen [::]:80;
#
#       server_name example.com;
#
#       root /var/www/example.com;
#       index index.html;
#
#       location / {
#               try_files \$uri \$uri/ =404;
#       }
#}
")
}
