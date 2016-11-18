class role::sensu_enterprise {

  include profile::epel
  include profile::redis
  include profile::rabbitmq
  include profile::sensu_server

}
