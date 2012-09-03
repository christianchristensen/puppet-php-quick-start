class mysites (
  $sites = params_lookup('sites')
) {
  package { 'php5-fpm':
    ensure => present,
  }
  service { 'php5-fpm':
    ensure => running,
    require => Package['php5-fpm'],
  }

  class { 'nginx': }

  define install ($path = '/srv/www') {
    $vhost = $name
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

  create_resources('mysites::install', $sites)
}

