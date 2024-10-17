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
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dive # look into docker image layers
      docker-compose # start group of containers for dev
    ];
  };
}
