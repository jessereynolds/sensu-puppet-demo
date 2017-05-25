class role::sensu_linux_client {

  include profile::epel
  include profile::sensu_client

}
