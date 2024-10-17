args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.network;
in {
  imports = [];

  options.lonewanderer.hardware.network = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');

    enableNetworkManager = mkEnableOption (mdDoc ''
      Enable network manager
    '');

    useDHCP = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc ''
        Enable DHCP for all devices.
      '';
    };

    timeServers = mkOption {
      type = with types; listOf str;
      description = mdDoc ''
        Timeserver list
      '';
      default = ["time.cloudflare.com"];
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = ["tcp_bbr"];
    networking.useDHCP = cfg.enableNetworkManager == false && cfg.useDHCP;
    networking.networkmanager.enable = cfg.enableNetworkManager;
    networking.timeServers = cfg.timeServers;
  };
}
