file { '/var/www':
    ensure => directory,
    replace => true,
    owner => vagrant,
    group => vagrant,
}

symfony::project::create { 'test':
  user        => 'vagrant',
  working_dir => '/var/www',
}
