args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.firewall;
in {
  imports = [];

  options.lonewanderer.system.security.firewall = {
    enable = mkEnableOption (mdDoc ''
      enable firewall settings
    '');
  };

  config = mkIf (config.lonewanderer.hardware.network.enable && cfg.enable) {
    networking.nftables.enable = true;

    networking.firewall = {
      allowPing = false;
      enable = true;
      filterForward = true;
      logReversePathDrops = true;
      logRefusedPackets = true;
      logRefusedConnections = true;
      trustedInterfaces = [];
    };
  };
}
