# puppet-symfony #

Puppet module for preparing and installing Symfony2 projects

## Examples ##


Creating the latest SE in /var/www/test for custom user


    symfony::project::create { 'test':
      user        => 'www-data',
      working_dir => '/var/www',
    }


Creating a concrete SE version in /var/www/test_2.3.1 as root

    symfony::project::create { 'test_2.3.1':
      version     => '2.3.1',
      working_dir => '/var/www',
    }
