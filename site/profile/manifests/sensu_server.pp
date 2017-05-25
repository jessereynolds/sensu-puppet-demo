# Puppet Profile to demonstrate creation of a Sensu Enterprise server.
# Makes use of the Sensu module from Sensu
# https://github.com/sensu/sensu-puppet
class profile::sensu_server {

  unless $::sensu_enterprise_user and $::sensu_enterprise_password {
    fail(join(['Please set $::sensu_enterprise_user and $::sensu_enterprise_password as',
      ' variables or external facts. These should correspond to your account with Sensu.']))
  }

  $u_type = type($::sensu_enterprise_user)
  $p_type = type($::sensu_enterprise_password)

  class { '::sensu':
    install_repo         => true,
    enterprise           => true,
    enterprise_dashboard => true,
    enterprise_user      => $::sensu_enterprise_user,
    enterprise_pass      => $::sensu_enterprise_password,
    manage_services      => true,
    manage_user          => true,
    rabbitmq_password    => 'fandango-tulip-soldier',
    rabbitmq_vhost       => '/sensu',
    client_address       => $::ipaddress,
  }

  sensu::check { 'check_ntp':
    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_ntp_time -H pool.ntp.org -w 30 -c 60',
    handlers    => 'default',
    subscribers => 'sensu-test',
  }

  package { 'rubygems':
    ensure => present,
  }

}
