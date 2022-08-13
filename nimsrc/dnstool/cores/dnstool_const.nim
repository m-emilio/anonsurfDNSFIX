const
  system_dns_file* = "/etc/resolv.conf"
  system_dns_backup* = "/etc/resolv.conf.bak"
  resolvconf_dns_file* = "/run/resolvconf/resolv.conf"
  dhclient_dns_file* = "/var/lib/dhcp/dhclient.leases"
  resolvconf_tail_file* = "/etc/resolvconf/resolv.conf.d/tail"
  dhclient_binary* = "/usr/sbin/dhclient"
  hook_script_dhcp_path* = "/etc/dhcp/dhclient-enter-hooks.d/dnstool"
  hook_script_dhcp_data* = "make_resolv_conf() { :; }"
  # https://www.cyberciti.biz/faq/dhclient-etcresolvconf-hooks/
  # This path only works with Debian based
  # hook_script_resolvconf_path* = "/etc/dhcp/dhclient-enter-hooks.d/resolvconf"
  hook_script_if_down_path* = "/etc/NetworkManager/dispatcher.d/pre-down.d/dnstool"
  hook_script_if_down_data* = "#!/bin/sh\n/usr/bin/dnstool create-backup\n"
  hook_script_if_up_path* = "/etc/network/if-up.d/dnstool"
  hook_script_if_up_data* = "#!/bin/sh\n/usr/bin/dnstool restore-backup\n"
  hook_script_sys_shutdown_path* = "/etc/network/if-down.d/dnstool"
  hook_script_sys_shutdown_data* = "#!/bin/sh\n/usr/bin/dnstool create-backup\n"
  hook_script_sys_start_path* = "/etc/network/if-pre-up.d/dnstool"
  hook_script_sys_start_data* = "#!/bin/sh\n/usr/bin/dnstool status\n" # Don't know why NetworkManager needs this

type
  AddrFromParams* = object
    has_dhcp_flag*: bool
    list_addr*: seq[string]
