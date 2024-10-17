args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.video;
in {
  options.lonewanderer.hardware.video = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');

    amd.enable = mkEnableOption (mdDoc ''
      enable AMD
    '');

    nvidia.enable = mkEnableOption (mdDoc ''
      enable Nvidia
    '');
  };

  config =
    mkIf cfg.enable {
    };
}
