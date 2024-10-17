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

    lonewanderer.system = {
      boot.plymouth.enable = mkDefault true;
    };

    lonewanderer.hardware = {
      audio.enable = mkDefault true;
      bluetooth.enable = mkDefault true;
      display.enable = mkDefault true;
      network.enable = mkDefault true;
      network.useDHCP = mkDefault false;
      network.enableNetworkManager = mkDefault true;
      security.enable = mkDefault true;
      usb.enable = mkDefault true;
      video.enable = mkDefault true;
      webcam.enable = mkDefault true;
      wifi.enable = mkDefault true;
    };

    lonewanderer.programs.desktop = {
      enable = true;
      greetd.enable = mkDefault true;
      hyprland.enable = mkDefault true;
      hyprlock.enable = mkDefault true;
      xdg.enable = mkDefault true;
    };

    lonewanderer.services = {
      flatpak.enable = mkDefault true;
    };

    system.nixos.tags = ["desktop"];
  };
}
