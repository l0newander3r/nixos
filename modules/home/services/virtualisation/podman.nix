{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.podman;
in {
  options.lonewanderer.services.virtualisation.podman = {
    enable = mkEnableOption (mdDoc ''
      Enable podman
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      podman-compose # start group of containers for dev
    ];
  };
}
