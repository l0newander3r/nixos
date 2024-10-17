{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprland;

  enableXdg = config.lonewanderer.programs.desktop.xdg.enable;

  portalConfig = mkIf enableXdg [
    "hyprland"
    "gtk"
  ];
in {
  options.lonewanderer.programs.desktop.hyprland = {
    enable = mkEnableOption (mdDoc ''
      enable hyprland
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = config.lonewanderer.programs.desktop.enableXwayland;
    };

    xdg.portal.config.common.default = portalConfig;
    xdg.portal.config.hyprland.default = portalConfig;
  };
}
