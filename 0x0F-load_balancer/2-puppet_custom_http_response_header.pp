#Just as in task #0, we’d like you to automate the task of creating a custom HTTP header response, but with Puppet.

#The name of the custom HTTP header must be X-Served-By
#The value of the custom HTTP header must be the hostname of the server Nginx is running on
#Write 2-puppet_custom_http_response_header.pp so that it configures a brand new Ubuntu machine to the requirements asked in this task

# Installs Nginx and custom HTTP response headers

exec { '/usr/bin/env apt-get -y update':
  command     => '/usr/bin/env apt-get -y update',
  path        => ['/usr/bin', '/bin'],
  refreshonly => true,
}

package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  content => 'Holberton School!',
}

file_line { 'add header':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  line   => "\tadd_header X-Served-By ${hostname};",
  after  => 'server_name _;',
  require => Package['nginx'],
}

service { 'nginx':
  ensure => running,
  require => [Package['nginx'], File_line['add header']],
}
