t 1-install_a_package.pp
# install flask
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip'
}
