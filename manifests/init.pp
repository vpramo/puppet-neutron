# == Class: neutron
#
# Installs the neutron package and configures
# /etc/neutron/neutron.conf
#
# === Parameters:
#
# [*enabled*]
#   (required) Whether or not to enable the neutron service
#   true/false
#
# [*package_ensure*]
#   (optional) The state of the package
#   Defaults to 'present'
#
# [*debug*]
#   (optional) Print debug messages in the logs
#   Defaults to undef
#
# [*bind_host*]
#   (optional) The IP/interface to bind to
#   Defaults to $::os_service_default
#
# [*bind_port*]
#   (optional) The port to use
#   Defaults to $::os_service_default
#
# [*core_plugin*]
#   (optional) Neutron plugin provider
#   Defaults to openvswitch
#   Could be bigswitch, brocade, cisco, embrane, hyperv, linuxbridge, midonet, ml2, mlnx, nec, nicira, plumgrid, ryu, nuage, opencontrail (full path)
#
#   Example for opencontrail:
#
#     class {'neutron' :
#       core_plugin => 'neutron.plugins.opencontrail.contrail_plugin:NeutronPluginContrailCoreV2'
#     }
#
# [*service_plugins*]
#   (optional) Advanced service modules.
#   Could be an array that can have these elements:
#   router, firewall, lbaas, vpnaas, metering, qos
#   Defaults to $::os_service_default
#
# [*auth_strategy*]
#   (optional) How to authenticate
#   Defaults to 'keystone'. 'noauth' and 'keystone' are the only valid options
#
# [*base_mac*]
#   (optional) The MAC address pattern to use.
#   Defaults to $::os_service_default
#
# [*mac_generation_retries*]
#   (optional) How many times to try to generate a unique mac
#   Defaults to $::os_service_default
#
# [*dhcp_lease_duration*]
#   (optional) DHCP lease
#   Defaults to $::os_service_default
#
# [*dns_domain*]
#   (optional) Domain to use for building the hostnames
#   Defaults to $::os_service_default
#
# [*dhcp_agents_per_network*]
#   (optional) Number of DHCP agents scheduled to host a network.
#   This enables redundant DHCP agents for configured networks.
#   Defaults to $::os_service_default
#
# [*global_physnet_mtu*]
#   (optional) The MTU size for the interfaces managed by neutron
#   Defaults to $::os_service_default
#
# [*dhcp_agent_notification*]
#   (optional) Allow sending resource operation notification to DHCP agent.
#   Defaults to $::os_service_default
#
# [*advertise_mtu*]
#   (optional) VMs will receive DHCP and RA MTU option when the network's preferred MTU is known
#   Defaults to $::os_service_default
#
# [*allow_bulk*]
#   (optional) Enable bulk crud operations
#   Defaults to $::os_service_default
#
# [*allow_pagination*]
#   (optional) Enable pagination
#   Defaults to $::os_service_default
#
# [*allow_sorting*]
#   (optional) Enable sorting
#   Defaults to $::os_service_default
#
# [*allow_overlapping_ips*]
#   (optional) Enables network namespaces
#   Defaults to $::os_service_default
#
# [*api_extensions_path*]
#   (optional) Specify additional paths for API extensions that the
#   module in use needs to load.
#   Defaults to $::os_service_default
#
# [*root_helper*]
#  (optional) Use "sudo neutron-rootwrap /etc/neutron/rootwrap.conf" to use the real
#  root filter facility. Change to "sudo" to skip the filtering and just run the command
#  directly
#  Defaults to 'sudo neutron-rootwrap /etc/neutron/rootwrap.conf'.
#
# [*report_interval*]
#   (optional) Seconds between nodes reporting state to server; should be less than
#   agent_down_time, best if it is half or less than agent_down_time.
#   agent_down_time is a config for neutron-server, set by class neutron::server
#   report_interval is a config for neutron agents, set by class neutron
#   Defaults to: $::os_service_default
#
# [*memcache_servers*]
#   List of memcache servers in format of server:port.
#   Optional. Defaults to false. Example: ['localhost:11211']
#
# [*control_exchange*]
#   (optional) What RPC queue/exchange to use
#   Defaults to neutron

# [*rpc_backend*]
#   (optional) what rpc/queuing service to use
#   Defaults to $::os_service_default
#
# [*rpc_response_timeout*]
#   (optional) Seconds to wait for a response from a call
#   Defaults to $::os_service_default
#
# [*rabbit_password*]
# [*rabbit_host*]
# [*rabbit_port*]
# [*rabbit_user*]
#   (optional) Various rabbitmq settings
#   Defaults to $::os_service_default
#
# [*rabbit_virtual_host*]
#   (optional) virtualhost to use.
#   Defaults to $::os_service_default
#
# [*rabbit_hosts*]
#   (optional) array of rabbitmq servers for HA.
#   A single IP address, such as a VIP, can be used for load-balancing
#   multiple RabbitMQ Brokers.
#   Defaults to $::os_service_default
#
# [*rabbit_ha_queues*]
#   (Optional) Use HA queues in RabbitMQ.
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   (Requires kombu >= 3.0.7 and amqp >= 1.4.0)
#   Defaults to $::os_service_default
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period to
#   check the heartbeat on RabbitMQ connection.  (i.e. rabbit_heartbeat_rate=2
#   when rabbit_heartbeat_timeout_threshold=60, the heartbeat will be checked
#   every 30 seconds.
#   Defaults to $::os_service_default
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ
#   Defaults to $::os_service_default
#
# [*amqp_durable_queues*]
#   (optional) Define queues as "durable" to rabbitmq.
#   Defaults to $::os_service_default
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions.
#   Defaults to $::os_service_default
#
# [*kombu_reconnect_delay*]
#   (optional) The amount of time to wait before attempting to reconnect
#   to MQ provider. This is used in some cases where you may need to wait
#   for the provider to propery premote the master before attempting to
#   reconnect. See https://review.openstack.org/#/c/76686
#   Defaults to $::os_service_default
#
# [*use_ssl*]
#   (optinal) Enable SSL on the API server
#   Defaults to $::os_service_default
#
# [*cert_file*]
#   (optinal) certificate file to use when starting api server securely
#   defaults to $::os_service_default
#
# [*key_file*]
#   (optional) Private key file to use when starting API server securely
#   Defaults to $::os_service_default
#
# [*ca_file*]
#   (optional) CA certificate file to use to verify connecting clients
#   Defaults to $::os_service_default
#
# [*use_syslog*]
#   (optional) Use syslog for logging
#   Defaults to undef
#
# [*use_stderr*]
#   (optional) Use stderr for logging
#   Defaults to undef
#
# [*log_facility*]
#   (optional) Syslog facility to receive log lines
#   Defaults to undef
#
# [*log_file*]
#   (optional) Where to log
#   Defaults to undef
#
# [*log_dir*]
#   (optional) Directory where logs should be stored
#   If set to boolean false, it will not log to any directory
#   Defaults to undef
#
# [*manage_logging*]
#   (optional) Whether to manage olso.logging options
#   If set to false, neutron::logging class should be evaluated
#   Defaults to true.
#
# [*state_path*]
#   (optional) Where to store state files. This directory must be writable
#   by the user executing the agent
#   Defaults to: $::os_service_default
#
# [*lock_path*]
#   (optional) Where to store lock files. This directory must be writeable
#   by the user executing the agent
#   Defaults to: '$state_path/lock'
#
# [*purge_config*]
#   (optional) Whether to set only the specified config options
#   in the neutron config.
#   Defaults to false.
#
# [*notification_driver*]
#   (optional) Driver or drivers to handle sending notifications.
#   Value can be a string or a list.
#   Defaults to $::os_service_default.
#
# [*notification_topics*]
#   (optional) AMQP topic used for OpenStack notifications
#   Defaults to ::os_service_default
#
# [*notification_transport_url*]
#   (optional) A URL representing the messaging driver to use for
#   notifications.
#   Defaults to $::os_service_default.
#
# DEPRECATED PARAMETERS
#
# [*network_device_mtu*]
#
# [*verbose*]
#   (optional) Deprecated. Verbose logging
#   Defaults to undef
#
class neutron (
  $enabled                            = true,
  $package_ensure                     = 'present',
  $debug                              = undef,
  $bind_host                          = $::os_service_default,
  $bind_port                          = $::os_service_default,
  $core_plugin                        = 'openvswitch',
  $service_plugins                    = $::os_service_default,
  $auth_strategy                      = 'keystone',
  $base_mac                           = $::os_service_default,
  $mac_generation_retries             = $::os_service_default,
  $dhcp_lease_duration                = $::os_service_default,
  $dns_domain                         = $::os_service_default,
  $dhcp_agents_per_network            = $::os_service_default,
  $global_physnet_mtu                 = $::os_service_default,
  $dhcp_agent_notification            = $::os_service_default,
  $advertise_mtu                      = $::os_service_default,
  $allow_bulk                         = $::os_service_default,
  $allow_pagination                   = $::os_service_default,
  $allow_sorting                      = $::os_service_default,
  $allow_overlapping_ips              = $::os_service_default,
  $api_extensions_path                = $::os_service_default,
  $root_helper                        = 'sudo neutron-rootwrap /etc/neutron/rootwrap.conf',
  $report_interval                    = $::os_service_default,
  $memcache_servers                   = false,
  $control_exchange                   = 'neutron',
  $rpc_backend                        = $::os_service_default,
  $rpc_response_timeout               = $::os_service_default,
  $rabbit_password                    = $::os_service_default,
  $rabbit_host                        = $::os_service_default,
  $rabbit_hosts                       = $::os_service_default,
  $rabbit_port                        = $::os_service_default,
  $rabbit_ha_queues                   = $::os_service_default,
  $rabbit_user                        = $::os_service_default,
  $rabbit_virtual_host                = $::os_service_default,
  $rabbit_heartbeat_timeout_threshold = $::os_service_default,
  $rabbit_heartbeat_rate              = $::os_service_default,
  $rabbit_use_ssl                     = $::os_service_default,
  $amqp_durable_queues                = $::os_service_default,
  $kombu_ssl_ca_certs                 = $::os_service_default,
  $kombu_ssl_certfile                 = $::os_service_default,
  $kombu_ssl_keyfile                  = $::os_service_default,
  $kombu_ssl_version                  = $::os_service_default,
  $kombu_reconnect_delay              = $::os_service_default,
  $use_ssl                            = $::os_service_default,
  $cert_file                          = $::os_service_default,
  $key_file                           = $::os_service_default,
  $ca_file                            = $::os_service_default,
  $use_syslog                         = undef,
  $use_stderr                         = undef,
  $log_facility                       = undef,
  $log_file                           = undef,
  $log_dir                            = undef,
  $manage_logging                     = true,
  $state_path                         = $::os_service_default,
  $lock_path                          = '$state_path/lock',
  $purge_config                       = false,
  $notification_driver                = $::os_service_default,
  $notification_topics                = $::os_service_default,
  $notification_transport_url         = $::os_service_default,
  # DEPRECATED PARAMETERS
  $network_device_mtu                 = undef,
  $verbose                            = undef,
) {

  include ::neutron::params
  if $manage_logging {
    include ::neutron::logging
  }

  if ! is_service_default($use_ssl) and ($use_ssl) {
    if is_service_default($cert_file) {
      fail('The cert_file parameter is required when use_ssl is set to true')
    }
    if is_service_default($key_file) {
      fail('The key_file parameter is required when use_ssl is set to true')
    }
  }

  if ! is_service_default($use_ssl) and !($use_ssl) {
    if ! is_service_default($ca_file) and ($ca_file) {
      fail('The ca_file parameter requires that use_ssl to be set to true')
    }
  }

  if ! is_service_default($rabbit_use_ssl) and !($rabbit_use_ssl) {
    if ! is_service_default($kombu_ssl_ca_certs) and ($kombu_ssl_ca_certs) {
      fail('The kombu_ssl_ca_certs parameter requires rabbit_use_ssl to be set to true')
    }
    if ! is_service_default($kombu_ssl_certfile) and ($kombu_ssl_certfile) {
      fail('The kombu_ssl_certfile parameter requires rabbit_use_ssl to be set to true')
    }
    if ! is_service_default($kombu_ssl_keyfile) and ($kombu_ssl_keyfile) {
      fail('The kombu_ssl_keyfile parameter requires rabbit_use_ssl to be set to true')
    }
  }
  if (is_service_default($kombu_ssl_certfile) and ! is_service_default($kombu_ssl_keyfile)) or (is_service_default($kombu_ssl_keyfile) and ! is_service_default($kombu_ssl_certfile)) {
    fail('The kombu_ssl_certfile and kombu_ssl_keyfile parameters must be used together')
  }

  if $memcache_servers {
    validate_array($memcache_servers)
  }

  package { 'neutron':
    ensure => $package_ensure,
    name   => $::neutron::params::package_name,
    tag    => ['openstack', 'neutron-package'],
  }

  # Make sure all services get restarted if neutron-common package is upgraded
  Package['neutron'] ~> Service<| tag == 'neutron-service' |>

  resources { 'neutron_config':
    purge => $purge_config,
  }

  neutron_config {
    'DEFAULT/bind_host':               value => $bind_host;
    'DEFAULT/bind_port':               value => $bind_port;
    'DEFAULT/auth_strategy':           value => $auth_strategy;
    'DEFAULT/core_plugin':             value => $core_plugin;
    'DEFAULT/base_mac':                value => $base_mac;
    'DEFAULT/mac_generation_retries':  value => $mac_generation_retries;
    'DEFAULT/dhcp_lease_duration':     value => $dhcp_lease_duration;
    'DEFAULT/dns_domain':              value => $dns_domain;
    'DEFAULT/dhcp_agents_per_network': value => $dhcp_agents_per_network;
    'DEFAULT/dhcp_agent_notification': value => $dhcp_agent_notification;
    'DEFAULT/advertise_mtu':           value => $advertise_mtu;
    'DEFAULT/allow_bulk':              value => $allow_bulk;
    'DEFAULT/allow_pagination':        value => $allow_pagination;
    'DEFAULT/allow_sorting':           value => $allow_sorting;
    'DEFAULT/allow_overlapping_ips':   value => $allow_overlapping_ips;
    'DEFAULT/control_exchange':        value => $control_exchange;
    'DEFAULT/api_extensions_path':     value => $api_extensions_path;
    'DEFAULT/state_path':              value => $state_path;
    'DEFAULT/rpc_response_timeout':    value => $rpc_response_timeout;
    'DEFAULT/global_physnet_mtu':      value => pick($network_device_mtu, $global_physnet_mtu);
    'agent/root_helper':               value => $root_helper;
    'agent/report_interval':           value => $report_interval;
  }

  oslo::concurrency { 'neutron_config': lock_path => $lock_path }

  oslo::messaging::notifications { 'neutron_config':
    driver        => $notification_driver,
    topics        => $notification_topics,
    transport_url => $notification_transport_url,
  }

  if ! is_service_default ($service_plugins) and ($service_plugins) {
    if is_array($service_plugins) {
      neutron_config { 'DEFAULT/service_plugins': value => join($service_plugins, ',') }
    } else {
      fail('service_plugins should be an array.')
    }
  }

  if $memcache_servers {
    neutron_config {
      'DEFAULT/memcached_servers':  value => join($memcache_servers, ',');
    }
  } else {
    neutron_config {
      'DEFAULT/memcached_servers':  ensure => absent;
    }
  }


  if $rpc_backend in [$::os_service_default, 'neutron.openstack.common.rpc.impl_kombu', 'rabbit'] {
    if is_service_default($rabbit_password) {
      fail('When rpc_backend is rabbitmq, you must set rabbit password')
    }

    oslo::messaging::rabbit {'neutron_config':
      rabbit_userid               => $rabbit_user,
      rabbit_password             => $rabbit_password,
      rabbit_virtual_host         => $rabbit_virtual_host,
      heartbeat_timeout_threshold => $rabbit_heartbeat_timeout_threshold,
      heartbeat_rate              => $rabbit_heartbeat_rate,
      rabbit_use_ssl              => $rabbit_use_ssl,
      kombu_reconnect_delay       => $kombu_reconnect_delay,
      kombu_ssl_ca_certs          => $kombu_ssl_ca_certs,
      kombu_ssl_certfile          => $kombu_ssl_certfile,
      kombu_ssl_keyfile           => $kombu_ssl_keyfile,
      amqp_durable_queues         => $amqp_durable_queues,
      rabbit_hosts                => $rabbit_hosts,
      rabbit_ha_queues            => $rabbit_ha_queues,
      rabbit_host                 => $rabbit_host,
      rabbit_port                 => $rabbit_port,
      kombu_ssl_version           => $kombu_ssl_version,
    }
  } else {
    neutron_config {
      'DEFAULT/rpc_backend': value => $rpc_backend;
    }
  }

  if $network_device_mtu {
    warning('The neutron::network_device_mtu parameter is deprecated, use neutron::global_physnet_mtu instead.')
  }

  # SSL Options
  neutron_config {
    'DEFAULT/use_ssl': value => $use_ssl;
    'ssl/cert_file':   value => $cert_file;
    'ssl/key_file':    value => $key_file;
    'ssl/ca_file':     value => $ca_file;
  }

}
