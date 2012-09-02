node default {
  package { 'php5-fpm':
    ensure => present,
  }

  class { 'nginx': }
  nginx::resource::vhost { 'ec2-23-22-173-34.compute-1.amazonaws.com':
    location => '~ \.php$',
    locations => {
      0 => {
        'ensure' => present,
        'location' => '/',
        'try_files' => ['$uri', '$uri/', '@rewriteapp'],
      },
      1 => {
        'ensure' => present,
        'location' => '@rewriteapp',
        'options' => {'rewrite' => '^ /index.php last'},
      }
    },
    ensure   => present,
    www_root => '/srv/ec2-1',
    try_files => ['$uri', '$uri/'],
    fastcgi => '127.0.0.1:9000',
    fastcgi_script => '$document_root$fastcgi_script_name',
  }

  service { 'php5-fpm':
    ensure => running,
    require => Package['php5-fpm'],
  }
}

