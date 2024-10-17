args @ {
  lib,
  config,
  options,
  pkgs,
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
    home.packages = with pkgs; [
      pavucontrol
    ];
    services.easyeffects.enable = config.lonewanderer.profiles.desktop.enable;
  };
}
