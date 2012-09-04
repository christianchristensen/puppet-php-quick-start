class imapnote {
  package { 'php5-cli':
    ensure => present,
  }

  puppi::project::git { "imapnote":
    source                  => "https://github.com/christianchristensen/iPhone-IMAP-Notes.git",
    deploy_root             => "/srv/imapnote",
    auto_deploy             => true,
    postdeploy_customcommand => ";(cd /srv/imapnote && curl -s https://getcomposer.org/installer | php && php composer.phar install)",
  }
}
