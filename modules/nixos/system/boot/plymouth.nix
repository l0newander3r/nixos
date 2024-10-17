args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.boot.plymouth;
in {
  imports = [];

  options.lonewanderer.system.boot.plymouth = {
    enable = mkEnableOption (mdDoc ''
      enable Plymouth
    '');
  };

  config = mkIf (config.lonewanderer.system.boot.enable && cfg.enable) {
    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;

    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # boot.loader.timeout = 0;

    boot.plymouth = {
      enable = true;
    };
  };
}
