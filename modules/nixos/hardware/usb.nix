args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.usb;
in {
  imports = [];

  options.lonewanderer.hardware.usb = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
