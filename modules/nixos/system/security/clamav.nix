args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.clamav;
in {
  imports = [];

  options.lonewanderer.system.security.clamav = {
    enable = mkEnableOption (mdDoc ''
      enable clamav virus scanner
    '');
  };

  config = mkIf cfg.enable {
    services.clamav = {
      daemon.enable = true;
      fangfrisch.enable = true;
      scanner.enable = true;
      updater.enable = true;
    };
  };
}
