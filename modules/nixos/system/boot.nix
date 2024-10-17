args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.boot;
in {
  imports = [
    (import ./boot/lanzaboote.nix args)
    (import ./boot/plymouth.nix args)
  ];

  options.lonewanderer.system.boot = {
    enable = mkEnableOption (mdDoc ''
      enable custom boot settings
    '');
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;

    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    boot.loader.systemd-boot = {
      enable = mkForce (!cfg.lanzaboote.enable);
      consoleMode = "max";
      configurationLimit = 10;
      editor = false;
    };

    boot.tmp.useTmpfs = true;

    systemd.services.nix-daemon = {
      environment.TMPDIR = "/var/tmp";
    };
  };
}
