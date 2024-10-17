args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop;
in {
  imports = [
    (import ./desktop/greetd.nix args)
    (import ./desktop/hyprland.nix args)
    (import ./desktop/hyprlock.nix args)
    (import ./desktop/xdg.nix args)
  ];

  options.lonewanderer.programs.desktop = {
    enable = mkEnableOption (mdDoc ''
      enable desktop mode
    '');

    enableXwayland = mkEnableOption (mdDoc ''
      enable desktop mode
    '');
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = mkDefault true;

    services.dbus.packages = with pkgs; [gcr];
    services.gvfs.enable = true;

    programs.xwayland.enable = cfg.enableXwayland;
    fonts.fontDir.enable = mkDefault true;
  };
}
