#replace .phpp with .php
exec { 'updateSettings':
  command  => 'sed -i "s/\b.phpp\b/.php/g" /var/www/html/wp-settings.php',
  provider => shell,
}
