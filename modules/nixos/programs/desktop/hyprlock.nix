{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprlock;
in {
  options.lonewanderer.programs.desktop.hyprlock = {
    enable = mkEnableOption (mdDoc ''
      enable hyprland
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    security.pam.services.hyprlock = {
      u2fAuth = config.lonewanderer.system.security.u2f.enable;
      enableGnomeKeyring = true;
    };
  };
}
