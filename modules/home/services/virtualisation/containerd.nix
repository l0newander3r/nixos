{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.containerd;
in {
  options.lonewanderer.services.virtualisation.containerd = {
    enable = mkEnableOption (mdDoc ''
      Enable containerd
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
