#Just as in task #0, we’d like you to automate the task of creating a custom HTTP header response, but with Puppet.

#The name of the custom HTTP header must be X-Served-By
#The value of the custom HTTP header must be the hostname of the server Nginx is running on
#Write 2-puppet_custom_http_response_header.pp so that it configures a brand new Ubuntu machine to the requirements asked in this task

# Installs Nginx and custom HTTP response headers

# This Puppet manifest configures a new server to act as a web server

exec { 'update_and_upgrade':
  command => '/usr/bin/env apt-get -y update && /usr/bin/env apt-get -y upgrade',
}

package { 'nginx':
  ensure  => installed,
  require => Exec['update_and_upgrade'],
}

exec { 'allow_port_80':
  command => '/usr/bin/env ufw allow 80',
  require => Package['nginx'],
}

file { '/var/www/custom':
  ensure => directory,
}

file { '/var/www/custom/index.html':
  content => 'Hello World!',
}

file { '/var/www/custom/custom_404.html':
  content => "Ceci n'est pas une page",
}

file { '/etc/nginx/sites-available/custom':
  ensure  => present,
  source  => '/etc/nginx/sites-available/default',
  require => Package['nginx'],
}

exec { 'remove_default_server':
  command => '/bin/sed -i "s/default_server//g" /etc/nginx/sites-available/custom',
  require => File['/etc/nginx/sites-available/custom'],
}

exec { 'modify_root':
  command => '/bin/sed -i "s-root /var/www/html-root /var/www/custom-" /etc/nginx/sites-available/custom',
  require => Exec['remove_default_server'],
}

exec { 'add_custom_config':
  command => '/bin/sed -i "/server_name _;/s,$,\n\trewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;\n\terror_page 404 /custom_404.html;\n\tlocation = /custom_404.html {\n\t\troot /var/www/custom;\n\t\tinternal;\n\t}\n\tadd_header X-Served-By $HOSTNAME;," /etc/nginx/sites-available/custom',
  require => Exec['modify_root'],
}

file { '/etc/nginx/sites-enabled/custom':
  ensure  => link,
  target  => '/etc/nginx/sites-available/custom',
  require => Exec['add_custom_config'],
}

file { '/etc/nginx/sites-enabled/default':
  ensure => absent,
  notify => Service['nginx'],
}

exec { 'test_nginx_config':
  command => '/usr/sbin/nginx -t',
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Exec['test_nginx_config'],
}
