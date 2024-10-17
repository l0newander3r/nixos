args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  enc = config.lonewanderer.system.security.encryption;
  cfg = config.lonewanderer.system.security.backup;
in {
  imports = [];

  options.lonewanderer.system.security.backup = {
    enable = mkEnableOption (mdDoc ''
      enable backup disk
    '');

    offset = mkOption {
      type = with types; int;
      description = mdDoc ''
        The index for the header location to use, will be multiplied by
        the supplied multiplier to seek for a position in the keyfile.
      '';
    };
  };

  config = mkIf (enc.enable && cfg.enable) {
    # boot.initrd.luks.devices."30-backup" = {
    #   device = "/dev/disk/by-label/backup";
    #   keyFileSize = 4096;
    #   keyFileOffset = cfg.offset;
    #   keyFile = "/dev/mapper/00-key";
    #   crypttabExtraOpts = ["nofail" "x-initrd.attach"];
    #   allowDiscards = true;
    #   bypassWorkqueues = true;
    # };

    # fileSystems."/home/${config.lonewanderer.system.user.username}/backup" = {
    #   device = "/dev/mapper/30-backup";
    #   options = [
    #     "discard"
    #     "noatime"
    #     "nofail"
    #     "x-systemd.automount"
    #     "x-systemd.device-timeout=3"
    #   ];
    # };
  };
}
