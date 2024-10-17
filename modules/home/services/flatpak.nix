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
    # systemd.user.services.flatpak-fonts = {
    #   wantedBy = ["multi-user.target"];
    #   path = [pkgs.flatpak];
    #   script = ''
    #     ln -sf /run/current-system/sw/share/X11/fonts $XDG_DATA_HOME/fonts
    #     flatpak --user override --filesystem=$HOME/.local/share/fonts:ro
    #     flatpak --user override --filesystem=$HOME/.icons:ro
    #     flatpak --user override --filesystem=/nix/store:ro
    #   '';
    # };
  };
}
