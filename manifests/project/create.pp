# == Class: symfony
#
# Installs the Symfony2 Standard Edition on the machine.
#
# === Parameters
#
# [*version*]
#    the Symfony2 version (2.3.0, 2.3.1 etc),
#    if not defined the latest one will be taken
# [*user*]
#    the owner of the project (defaults to root)
# [*working_dir*]
#    the directory where the composer command should be executed in.
#    The creation of this directory has to be ensured outside of this resource!
#
# === Examples
#
# symfony::project::create { 'test':
#   user        => 'vagrant',
#   working_dir => '/var/www',
# }
#
#
define symfony::project::create (
  $version     = undef,
  $user        = 'root',
  $working_dir = undef,
) {

  # could not get it running without changing the working dir of composer in combination with puppet
  $content = "#!/bin/sh
    composer --no-interaction create-project symfony/framework-standard-edition ${name} ${version} > composer.log
  "

  file { "${working_dir}/create_project.sh":
    ensure  => present,
    owner   => $user,
    group   => $user,
    content => $content,
    mode    => '0744'
  }

  exec { "symfony_project_create_${name}":
    command   => './create_project.sh',
    cwd       => $working_dir,
    path      => [$working_dir, '/usr/bin', '/usr/local/bin'],
    user      => $user,
    creates   => "${working_dir}/${name}/composer.json",
  }

}
