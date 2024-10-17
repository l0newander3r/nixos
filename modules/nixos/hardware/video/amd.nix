{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.video.amd;
in {
  options.lonewanderer.hardware.video.amd = {
    enable = mkEnableOption (mdDoc ''
      Enable AMD hardware acceleration support in the kernel.
    '');
  };

  config = mkIf (config.lonewanderer.hardware.video.enable && cfg.enable) {
    boot.initrd.kernelModules = ["amdgpu"];

    hardware.graphics = {
      extraPackages = [pkgs.amdvlk];
      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    };
  };
}
