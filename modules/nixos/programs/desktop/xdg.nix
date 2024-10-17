{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.xdg;
in {
  options.lonewanderer.programs.desktop.xdg = {
    enable = mkEnableOption (mdDoc ''
      enable xdg
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    xdg.autostart.enable = true;
    xdg.icons.enable = true;
    xdg.menus.enable = true;
    xdg.mime.enable = true;
    xdg.portal.enable = true;
    xdg.portal.xdgOpenUsePortal = true;
    xdg.portal.configPackages = [];

    xdg.portal.wlr = {
      enable = true;
      settings = {
        screencast = {
          chooser_type = "none";
          exec_before = "";
          exec_after = "";
        };
      };
    };

    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    xdg.portal.config.common.default = mkDefault [
      "gtk"
    ];

    xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [
      "gnome-keyring"
    ];
  };
}
