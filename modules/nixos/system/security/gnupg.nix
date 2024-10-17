args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.gnupg;
in {
  imports = [];

  options.lonewanderer.system.security.gnupg = {
    enable = mkEnableOption (mdDoc ''
      enable GnuPG global settings
    '');
  };

  config = mkIf cfg.enable {
    programs = {
      gnupg.dirmngr.enable = true;
      gnupg.agent = {
        enable = true;
        enableBrowserSocket = config.lonewanderer.profiles.desktop.enable;
        enableSSHSupport = true;
      };
    };
  };
}
