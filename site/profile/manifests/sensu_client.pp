class profile::sensu_client {
  class { '::sensu':
    rabbitmq_password => 'fandango-tulip-soldier',
    rabbitmq_host     => 'rabbit',
    rabbitmq_vhost    => '/sensu',
    subscriptions     => 'all',
    client_address    => $::ipaddress_eth1,
  }
}
