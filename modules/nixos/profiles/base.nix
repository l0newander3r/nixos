args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.base;
in {
  imports = [];

  options.lonewanderer.profiles.base = {
    enable = mkEnableOption (mdDoc ''
      enable base profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.hardware = {
      enableAllFirmware = true;
      enableFirmwareUpdate = true;
    };

    lonewanderer.system = {
      boot = {
        enable = mkDefault true;
        lanzaboote.enable = mkDefault true;
      };
      console.enable = mkDefault true;
      fonts.enable = mkDefault true;
      kernel.enable = mkDefault true;
      security = {
        clamav.enable = mkDefault true;
        encryption.enable = mkDefault true;
        firewall.enable = mkDefault true;
        gnupg.enable = mkDefault true;
        u2f.enable = mkDefault true;
      };
      themes.enable = mkDefault true;
      user.enable = mkDefault true;
    };
  };
}
