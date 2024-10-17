args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.encryption;
in {
  imports = [];

  options.lonewanderer.system.security.encryption = {
    enable = mkEnableOption (mdDoc ''
      enable encryption settings
    '');

    enableFido = mkEnableOption (mdDoc ''
      Enable FIDO2 support for unlocking encrypted drives
    '');

    key = mkOption {
      type = with types; str;
      default = "/dev/disk/by-label/key";
      description = mdDoc ''
        The location of the key device to unlock at boot
      '';
    };

    devices = mkOption {
      default = {};
      description = lib.mdDoc ''
        The encrypted disk that should be opened before the root
        filesystem is mounted. Both LVM-over-LUKS and LUKS-over-LVM
        setups are supported. The unencrypted devices can be accessed as
        {file}`/dev/mapper/«index»1-«name»`.
      '';

      type = with types;
        attrsOf (submodule (
          {
            config,
            name,
            ...
          }: {
            options = {
              name = mkOption {
                visible = false;
                default = name;
                example = "system";
                type = types.str;
                description = mdDoc "Name of the device.";
              };

              device = mkOption {
                example = "/dev/disk/by-id/disk-id";
                type = types.str;
                default = "/dev/disk/by-label/${name}";
                description = mdDoc "Path of the underlying encrypted block device.";
              };

              header = mkOption {
                example = "/dev/disk/by-id/disk-id";
                type = with types; str;
                default = "/dev/disk/by-label/${name}-header";
                description = mdDoc ''
                  The index for the header location to use, will be multiplied by
                  the supplied multiplier to seek for a position in the keyfile.
                '';
              };

              headerOffset = mkOption {
                type = with types; int;
                description = mdDoc ''
                  The index for the header location to use, will be multiplied by
                  the supplied multiplier to seek for a position in the keyfile.
                '';
              };

              offset = mkOption {
                type = with types; int;
                description = mdDoc ''
                  The index for the header location to use, will be multiplied by
                  the supplied multiplier to seek for a position in the keyfile.
                '';
              };
            };
          }
        ));
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.luks.devices =
      {
        "00-key" = {
          device = cfg.key;
          crypttabExtraOpts = ["x-initrd.attach"];
        };
      }
      // (attrsets.concatMapAttrs
        (name: x: {
          "10-${name}" = {
            device = x.header;
            keyFileSize = 4096;
            keyFileOffset = x.headerOffset;
            keyFile = "/dev/mapper/00-key";
            crypttabExtraOpts = ["x-initrd.attach"];
          };
          "20-${name}" = {
            device = x.device;
            header = "/dev/mapper/10-${name}";
            keyFileSize = 4096;
            keyFileOffset = x.offset;
            keyFile = "/dev/mapper/00-key";
            allowDiscards = true;
            bypassWorkqueues = true;
            crypttabExtraOpts = ["x-initrd.attach"];
          };
        })
        cfg.devices);
  };
}
