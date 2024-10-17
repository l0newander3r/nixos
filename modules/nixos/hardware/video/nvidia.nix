{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.video.nvidia;
in {
  options.lonewanderer.hardware.video.nvidia = {
    enable = mkEnableOption (mdDoc ''
      Enable Nvidia hardware acceleration support in the kernel.
    '');

    enablePowerManagement = mkEnableOption (mdDoc ''
      Enable Nvidia hardware acceleration support in the kernel.
    '');
  };

  config = mkIf (config.lonewanderer.hardware.video.enable && cfg.enable) {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = cfg.enablePowerManagement;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = config.lonewanderer.profiles.desktop.enable;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
