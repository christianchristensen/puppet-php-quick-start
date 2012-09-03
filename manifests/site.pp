class mysites {
  package { 'php5-fpm':
    ensure => present,
  }
  service { 'php5-fpm':
    ensure => running,
    require => Package['php5-fpm'],
  }

  class { 'nginx': }

  define install ($vhost = 'localhost', $path = '/srv/www') {
    nginx::resource::vhost { $vhost:
      location => '~ \.php$',
      locations => {
        "${vhost}-0" => {
          'ensure' => present,
          'location' => '/',
          'try_files' => ['$uri', '$uri/', '@rewriteapp'],
        },
        "${vhost}-1" => {
          'ensure' => present,
          'location' => '@rewriteapp',
          'options' => {'rewrite' => '^ /index.php last'},
        }
      },
      ensure   => present,
      www_root => $path,
      try_files => ['$uri', '$uri/'],
      fastcgi => '127.0.0.1:9000',
      fastcgi_script => '$document_root$fastcgi_script_name',
    }
  }
}

node default {
  class { 'mysites': }
  mysites::install { '_': vhost => '_', path => '/srv/www' }
  mysites::install { '1': vhost => 'localhost', path => '/srv/localhost' }
}

