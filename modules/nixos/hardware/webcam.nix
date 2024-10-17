args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.webcam;
in {
  imports = [];

  options.lonewanderer.hardware.webcam = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    environment.etc."modprobe.d/webcam.conf".text = ''
      options v4l2loopback devices=1 exclusive_caps=1
    '';
  };
}
