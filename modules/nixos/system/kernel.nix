args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.kernel;
in {
  imports = [];

  options.lonewanderer.system.kernel = {
    enable = mkEnableOption (mdDoc ''
      enable custom kernel settings
    '');

    randstructSeed = mkOption {
      type = types.str;
      default = "";
      description =
        mdDoc ''
        '';
    };
  };

  config = mkIf cfg.enable {
    boot.kernel.randstructSeed = cfg.randstructSeed;

    boot.kernel.sysctl = {
      "fs.file-max" = 65535;
      "fs.protected_hardlinks" = 1;
      "fs.protected_symlinks" = 1;
      "fs.suid_dumpable" = 0;
      "kernel.core_uses_pid" = 1;
      "kernel.ctrl-alt-del" = 0;
      "kernel.ftrace_enabled" = mkDefault false;
      "kernel.kptr_restrict" = mkOverride 500 2;
      "kernel.msgmax" = 65535;
      "kernel.msgmnb" = 65535;
      "kernel.pid_max" = 65535;
      "kernel.randomize_va_space" = 2;
      "kernel.shmall" = 268435456;
      "kernel.shmmax" = 268435456;
      "kernel.sysrq" = 0;
      "kernel.yama.ptrace_scope" = mkOverride 500 1;
      "kernel.unprivileged_userns_clone" = mkForce 1;
      "net.core.bpf_jit_enable" = mkDefault false;
      "net.core.default_qdisc" = mkDefault "fq";
      "net.core.dev_weight" = mkDefault 64;
      "net.core.netdev_max_backlog" = mkDefault 16384;
      "net.core.optmem_max" = mkDefault 65535;
      "net.core.rmem_default" = mkDefault 262144;
      "net.core.rmem_max" = mkDefault 16777216;
      "net.core.somaxconn" = mkDefault 32768;
      "net.core.wmem_default" = mkDefault 262144;
      "net.core.wmem_max" = mkDefault 16777216;
      "net.ipv4.conf.all.accept_redirects" = mkDefault 0;
      "net.ipv4.conf.all.accept_source_route" = mkDefault 0;
      "net.ipv4.conf.all.bootp_relay" = mkDefault 0;
      "net.ipv4.conf.all.forwarding" = mkOverride 0 100;
      "net.ipv4.conf.all.log_martians" = mkDefault 1;
      "net.ipv4.conf.all.proxy_arp" = mkDefault 0;
      "net.ipv4.conf.all.rp_filter" = mkDefault 1;
      "net.ipv4.conf.all.secure_redirects" = mkDefault 0;
      "net.ipv4.conf.all.send_redirects" = mkDefault 0;
      "net.ipv4.conf.default.accept_redirects" = mkDefault 0;
      "net.ipv4.conf.default.accept_source_route" = mkDefault 0;
      "net.ipv4.conf.default.forwarding" = mkOverride 0 100;
      "net.ipv4.conf.default.log_martians" = mkDefault 1;
      "net.ipv4.conf.default.rp_filter" = mkDefault 1;
      "net.ipv4.conf.default.secure_redirects" = mkDefault 0;
      "net.ipv4.conf.default.send_redirects" = mkDefault 0;
      "net.ipv4.conf.lo.accept_redirects" = mkDefault 0;
      "net.ipv4.conf.lo.accept_source_route" = mkDefault 0;
      "net.ipv4.conf.lo.log_martians" = mkDefault 0;
      "net.ipv4.conf.lo.rp_filter" = mkDefault 1;
      "net.ipv4.icmp_echo_ignore_all" = mkDefault 1;
      "net.ipv4.icmp_echo_ignore_broadcasts" = mkDefault 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = mkDefault 1;
      "net.ipv4.ip_forward" = mkOverride 0 100;
      "net.ipv4.ip_local_port_range" = mkDefault "1024 64999";
      "net.ipv4.tcp_fin_timeout" = mkDefault 15;
      "net.ipv4.tcp_keepalive_intvl" = mkDefault 15;
      "net.ipv4.tcp_keepalive_probes" = mkDefault 5;
      "net.ipv4.tcp_keepalive_time" = mkDefault 1800;
      "net.ipv4.tcp_max_orphans" = mkDefault 16384;
      "net.ipv4.tcp_max_syn_backlog" = mkDefault 2048;
      "net.ipv4.tcp_max_tw_buckets" = mkDefault 1440000;
      "net.ipv4.tcp_moderate_rcvbuf" = mkDefault 1;
      "net.ipv4.tcp_no_metrics_save" = mkDefault 1;
      "net.ipv4.tcp_orphan_retries" = mkDefault 0;
      "net.ipv4.tcp_reordering" = mkDefault 3;
      "net.ipv4.tcp_retries1" = mkDefault 3;
      "net.ipv4.tcp_retries2" = mkDefault 15;
      "net.ipv4.tcp_rfc1337" = mkDefault 1;
      "net.ipv4.tcp_rmem" = mkDefault "8192 87380 16777216";
      "net.ipv4.tcp_sack" = mkDefault 0;
      "net.ipv4.tcp_slow_start_after_idle" = mkDefault 0;
      "net.ipv4.tcp_syn_retries" = mkDefault 5;
      "net.ipv4.tcp_synack_retries" = mkDefault 2;
      "net.ipv4.tcp_syncookies" = mkDefault 1;
      "net.ipv4.tcp_timestamps" = mkDefault 1;
      "net.ipv4.tcp_tw_reuse" = mkDefault 1;
      "net.ipv4.tcp_window_scaling" = mkDefault 0;
      "net.ipv4.tcp_wmem" = mkDefault "8192 65536 16777216";
      "net.ipv4.udp_rmem_min" = mkDefault 16384;
      "net.ipv4.udp_wmem_min" = mkDefault 16384;
      "net.ipv6.conf.all.accept_ra" = mkDefault 0;
      "net.ipv6.conf.all.accept_redirects" = mkDefault 0;
      "net.ipv6.conf.all.accept_source_route" = mkDefault 0;
      "net.ipv6.conf.all.autoconf" = mkDefault 0;
      "net.ipv6.conf.all.forwarding" = mkOverride 0 100;
      "net.ipv6.conf.default.accept_ra_defrtr" = mkDefault 0;
      "net.ipv6.conf.default.accept_ra_pinfo" = mkDefault 0;
      "net.ipv6.conf.default.accept_ra_rtr_pref" = mkDefault 0;
      "net.ipv6.conf.default.accept_ra" = mkDefault 0;
      "net.ipv6.conf.default.accept_redirects" = mkDefault 0;
      "net.ipv6.conf.default.accept_source_route" = mkDefault 0;
      "net.ipv6.conf.default.autoconf" = mkDefault 0;
      "net.ipv6.conf.default.dad_transmits" = mkDefault 0;
      "net.ipv6.conf.default.forwarding" = mkOverride 0 100;
      "net.ipv6.conf.default.max_addresses" = mkDefault 1;
      "net.ipv6.conf.default.router_solicitations" = mkDefault 0;
      "net.ipv6.route.flush" = mkDefault 1;
      "net.unix.max_dgram_qlen" = mkDefault 50;
      "vm.dirty_background_ratio" = mkDefault 5;
      "vm.dirty_ratigpgmit_ratio" = mkDefault 50;
    };

    boot.kernel.sysctl."vm.swappiness" =
      if (config.lonewanderer.system.filesystem.swapDevices != [])
      then 30
      else 0;

    services.dbus.apparmor = "enabled";

    security.apparmor.packages = with pkgs; [
      apparmor-utils
      apparmor-profiles
    ];
  };
}
