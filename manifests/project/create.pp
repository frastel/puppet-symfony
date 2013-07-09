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
#    the owner of the project
# [*working_dir*]
#    the directory where the composer command should be executed in
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
  $user        = undef,
  $working_dir = undef,
) {

  exec { "symfony_project_create_${name}":
    command => "composer --no-interaction create-project symfony/framework-standard-edition ${name} ${version} --working-dir=${working_dir}",
    creates => "${working_dir}/${name}/composer.json",
    path    => ['/usr/bin', '/usr/local/bin'],
  }

  # composer command could not be called directly with given
  # user due to some strange file permission problems
  # therefore this ugly chown is done afterwards
  if $user {
    exec { "symfony_project_fix_user_${name}":
      command => "chown -R ${user}:${user} ${working_dir}/${name}",
      path    => ['/bin'],
      require => Exec["symfony_project_create_${name}"],
    }
  }

}
