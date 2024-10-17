{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  theme = config.lonewanderer.system.themes;
  cfg = config.lonewanderer.programs.desktop.gtk;

  gtkSettings = {
    gtk-application-prefer-dark-theme = 1;
  };
in {
  options.lonewanderer.programs.desktop.gtk = {
    enable = mkEnableOption (mdDoc ''
      enable GTK
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    home.pointerCursor = {
      gtk.enable = true;
      # name = theme.cursor.name;
      # package = theme.cursor.package;
      # size = theme.cursor.size;
    };

    home.sessionVariables = {
      # GTK_THEME = cfg.gtkTheme;
      XCURSOR_SIZE = theme.cursor.size;
      XCURSOR_THEME = theme.cursor.name;
    };

    gtk.enable = true;
    gtk.cursorTheme = theme.cursor;

    gtk.iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
    };

    gtk.gtk3.extraConfig = gtkSettings;
    gtk.gtk4.extraConfig = gtkSettings;
  };
}
