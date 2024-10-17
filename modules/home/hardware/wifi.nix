args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.wifi;
in {
  imports = [];

  options.lonewanderer.hardware.wifi = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
