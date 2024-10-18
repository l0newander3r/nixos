{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprpanel;
in {
  options.lonewanderer.programs.desktop.hyprpanel = {
    enable = mkEnableOption (mdDoc ''
      enable hyprpaper
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    lonewanderer.programs.desktop.hyprland = {
      enable = mkForce true;
      widgets = getExe pkgs.hyprpanel;
    };

    home.packages = with pkgs; [
      hyprpanel
    ];
  };
}
