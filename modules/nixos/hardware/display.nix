args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.display;
in {
  imports = [];

  options.lonewanderer.hardware.display = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    hardware.i2c = {
      enable = true;
    };
  };
}
