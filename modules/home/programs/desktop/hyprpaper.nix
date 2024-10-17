{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprpaper;
in {
  options.lonewanderer.programs.desktop.hyprpaper = {
    enable = mkEnableOption (mdDoc ''
      enable hyprpaper
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    lonewanderer.programs.desktop.hyprland.enable = mkForce true;

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [];
        wallpaper = [];
      };
    };
  };
}
