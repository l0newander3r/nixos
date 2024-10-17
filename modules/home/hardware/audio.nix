args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.audio;
in {
  options.lonewanderer.hardware.audio = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    services.easyeffects.enable = config.lonewanderer.profiles.desktop.enable;
  };
}
