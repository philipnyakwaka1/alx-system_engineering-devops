# terminates a process killmenow

exec { 'killmenow':
  command => '/usr/bin/pkill -f "killmenow"',
  path    => '/usr/bin/:/usr/local/bin/:/bin/',
}
