class profile::rabbitmq {
  class {'::rabbitmq':
    delete_guest_user => true,
  }

  rabbitmq_vhost { 'sensu':
    ensure => present,
  }

  rabbitmq_user {'sensu':
    admin    => true,
    password => 'fandango-tulip-soldier',
  }

  rabbitmq_user_permissions { 'sensu@sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

}
