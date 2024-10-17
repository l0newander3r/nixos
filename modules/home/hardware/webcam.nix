args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.webcam;
in {
  options.lonewanderer.hardware.webcam = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
