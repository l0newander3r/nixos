args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.desktop;
in {
  imports = [];

  options.lonewanderer.profiles.desktop = {
    enable = mkEnableOption (mdDoc ''
      enable desktop profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.base.enable = true;

    lonewanderer.hardware = {
      audio.enable = mkDefault true;
      bluetooth.enable = mkDefault true;
      display.enable = mkDefault true;
      network.enable = mkDefault true;
      security.enable = mkDefault true;
      usb.enable = mkDefault true;
      video.enable = mkDefault true;
      webcam.enable = mkDefault true;
      wifi.enable = mkDefault true;
    };

    lonewanderer.programs.browser = {
      chromium.enable = true;
    };

    lonewanderer.programs.desktop = {
      enable = true;
      ags.enable = mkDefault true;
      gtk.enable = mkDefault true;
      hypridle.enable = mkDefault true;
      hyprland.enable = mkDefault true;
      hyprlock.enable = mkDefault true;
      hyprpanel.enable = mkDefault false;
      hyprpaper.enable = mkDefault true;
      xdg.enable = mkDefault true;
      xdg.enableUserDirs = mkDefault true;
    };

    lonewanderer.programs.editor = {
      neovim.enable = true;
    };

    lonewanderer.programs.media = {
      mpd.enable = true;
      mpv.enable = true;
    };

    lonewanderer.programs.security = {
      keepassxc.enable = true;
    };

    lonewanderer.programs.terminal = {
      kitty.enable = true;
    };

    lonewanderer.programs.tools = {
      enable = true;
    };

    lonewanderer.services = {
      flatpak.enable = mkDefault true;
    };
  };
}
