#
# Installs the Symfony2 sandbox (standard edition) on the machine.
#
# Parameters:
# version - the Symfony2 version (2.3.0, 2.3.1 etc),
#           if not defined the latest one will be taken
# user    - the owner of the project
#
# Sample usage:
# symfony::sandbox { '/var/www/test':
#   user => 'vagrant',
# }
#
define symfony::sandbox (
  $version = undef,
  $user    = 'root',
) {

  exec { "symfony_sandbox_install_${name}":
    name    => "composer create-project symfony/framework-standard-edition ${name} ${version}",
    creates => $name,
    path    => ['/usr/bin', '/usr/local/bin'],
    user    => $user,
  }

}