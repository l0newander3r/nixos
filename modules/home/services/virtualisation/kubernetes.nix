{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.kubernetes;
in {
  options.lonewanderer.services.virtualisation.kubernetes = {
    enable = mkEnableOption (mdDoc ''
      Enable Kubernetes
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [k9s kubernetes-helm kubectl];
  };
}
