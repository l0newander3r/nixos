args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.flatpak;
in {
  imports = [];

  options.lonewanderer.services.flatpak = {
    enable = mkEnableOption (mdDoc ''
      enable flatpak
    '');
  };

  config = mkIf cfg.enable {
    fonts.fontDir.enable = mkForce true;

    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
