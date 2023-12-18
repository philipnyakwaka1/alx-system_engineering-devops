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
    require => Package['nginx'],
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure => file,
  source => 'puppet:///modules/nginx/default',
  notify => Service['nginx'],
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
  require => Package['nginx'],
}

# Create custom 404 page
file { '/usr/share/nginx/html/custom_404.html':
  ensure  => file,
  content => 'Ceci n\'est pas une page',
}

# Set up 301 redirect for /redirect_me
nginx::resource::vhost { 'default':
  ensure      => present,
  www_root    => '/var/www/html',
  listen_ip   => '0.0.0.0',
  listen_port => 80,
  index_files => ['index.html'],
  error_page  => ['404 /custom_404.html'],
  rewrite     => [
    '^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent',
  ],
}
