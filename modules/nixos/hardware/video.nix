args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.video;
in {
  imports = [
    (import ./video/amd.nix args)
    (import ./video/nvidia.nix args)
  ];

  options.lonewanderer.hardware.video = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    boot.blacklistedKernelModules = ["nouveau"];

    boot.extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    hardware.graphics.enable = true;
  };
}
