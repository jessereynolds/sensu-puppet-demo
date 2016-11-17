class profile::sensu_server {
  class { '::sensu':
    install_repo      => true,
    server            => true,
    manage_services   => true,
    manage_user       => true,
    rabbitmq_password => 'fandango-tulip-soldier',
    rabbitmq_vhost    => '/sensu',
    api               => true,
    api_user          => 'admin',
    api_password      => 'secret',
    client_address    => $::ipaddress_eth1,
  }

  sensu::check { 'check_ntp':
    command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_ntp_time -H pool.ntp.org -w 30 -c 60',
    handlers    => 'default',
    subscribers => 'sensu-test',
  }
}
