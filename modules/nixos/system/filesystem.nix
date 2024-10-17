args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.filesystem;
in {
  imports = [];

  options.lonewanderer.system.filesystem = {
    bootDevice = mkOption {
      type = types.str;
      default = "/dev/disk/by-label/EFI";
    };

    mdadmConfig = mkOption {
      type = types.lines;
      default = "";
      description = mdDoc ''
        Provide your mdadm.conf content to load the correct arrays on boot.
      '';
    };

    fileSystems = mkOption {
      default = {
        "/".device = "/dev/system/root";
        "/home".device = "/dev/system/home";
      };
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
                type = types.str;
                description = mdDoc "Device path.";
              };
              fsType = mkOption {
                type = types.str;
                default = "ext4";
                description = mdDoc "Device type.";
              };
              options = mkOption {
                type = types.listOf types.str;
                default = ["noatime" "discard"];
                description = mdDoc "Device options.";
              };
            };
          }
        ));
    };

    swapDevices = mkOption {
      type = with types; listOf str;
      default = [];
      description = mdDoc ''
        Enable swap in the kernel.
      '';
    };
  };

  config = {
    boot.swraid = {
      enable = cfg.mdadmConfig != "";
      mdadmConf = cfg.mdadmConfig;
    };

    fileSystems =
      (attrsets.concatMapAttrs (name: x: {
          "${name}" = {
            device = x.device;
            fsType = x.fsType;
            options = mkIf (x.options != []) x.options;
          };
        })
        cfg.fileSystems)
      // {
        "/boot/efi" = {
          device = cfg.bootDevice;
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
            "x-systemd.automount"
          ];
        };
      };

    services.fstrim.enable = true;

    swapDevices = lists.imap0 (i: v: {device = v;}) cfg.swapDevices;
  };
}
