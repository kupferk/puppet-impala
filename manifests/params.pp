# == Class hive::params
#
# This class is meant to be called from hive
# It sets variables according to platform
#
class impala::params {
  case $::osfamily {
    'Debian': {
      $packages = {
        common => [ 'impala' ],
        catalog => 'impala-catalog',
        server => 'impala-server',
        statestore => 'impala-state-store',
        frontend => 'impala-shell',
      }
      $daemons = {
        catalog => 'impala-catalog',
        statestore => 'impala-state-store',
        server => 'impala-server',
      }
    }
    'RedHat': {
      $packages = {
        common => [ 'impala' ],
        catalogd => 'impala-catalog',
        server => 'impala-server',
        statestore => 'impala-state-store',
        frontend => 'impala-shell',
      }
      $daemons = {
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $alternatives = $::osfamily ? {
    debian => 'cluster',
    redhat => undef,
  }
  $confdir = $::osfamily ? {
    debian => '/etc/impala/conf',
    redhat => '/etc/impala',
  }
  $config = '/etc/default/impala'

  $catalog_hostname = '127.0.0.1'
  $statestore_hostname = '127.0.0.1'
  $statestore_port = 24000
  $server_port = 22000
}
