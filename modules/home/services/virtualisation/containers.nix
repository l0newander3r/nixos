{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.containers;
in {
  options.lonewanderer.services.virtualisation.containers = {
    enable = mkEnableOption (mdDoc ''
      enable container support
    '');
  };

  config = mkIf cfg.enable {};
}
