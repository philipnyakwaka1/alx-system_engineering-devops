# Install ngnix using puppet

#update command
exec {'apt-get-update':
    command => '/usr/bin/apt-get update',
}

#install Nginx
package {'nginx':
    ensure  => installed,
    require => Exec['apt-get-update'],
}

#ensure Nginx is running
service {'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx],
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
  require => Package['nginx'],
}
exec {'redirect_me':
  command  => 'sed -i.bak "24i\	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
  provider => 'shell'
}