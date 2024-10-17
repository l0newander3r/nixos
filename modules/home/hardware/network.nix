args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.network;
in {
  imports = [];

  options.lonewanderer.hardware.network = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
