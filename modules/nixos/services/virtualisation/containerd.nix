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

  config = mkIf cfg.enable {
    lonewanderer.services.virtualisation.containers.enable = mkForce true;

    environment.systemPackages = with pkgs; [
      nerdctl
    ];

    virtualisation.containerd = {
      enable = true;
    };
  };
}
