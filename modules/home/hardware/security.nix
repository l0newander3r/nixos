args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.security;
in {
  imports = [];

  options.lonewanderer.hardware.security = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
