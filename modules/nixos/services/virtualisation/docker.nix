{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.docker;
in {
  options.lonewanderer.services.virtualisation.docker = {
    enable = mkEnableOption (mdDoc ''
      Enable docker
    '');

    enableOnBoot = mkEnableOption (mdDoc ''
      Enable docker on boot
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.services.virtualisation.containers.enable = mkForce true;

    virtualisation.docker = {
      enable = true;
      enableOnBoot = cfg.enableOnBoot;
      autoPrune.enable = mkDefault true;
      rootless = {
        enable = mkDefault true;
        setSocketVariable = true;
      };
    };
  };
}
