args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.bluetooth;
in {
  imports = [];

  options.lonewanderer.hardware.bluetooth = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [overskride];
  };
}
