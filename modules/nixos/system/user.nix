args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.user;
in {
  imports = [];

  options.lonewanderer.system.user = {
    enable = mkEnableOption (mdDoc ''
      enable custom user settings
    '');

    username = mkOption {
      type = types.str;
    };

    groups = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    users.users."${cfg.username}".extraGroups =
      cfg.groups
      ++ lists.optional config.lonewanderer.programs.editor.android-tools.enable "adbuser"
      ++ lists.optional config.lonewanderer.hardware.display.enable "i2c"
      ++ lists.optional config.lonewanderer.hardware.video.enable "video"
      ++ lists.optional config.lonewanderer.hardware.audio.enable "audio"
      ++ lists.optional config.lonewanderer.hardware.network.enable "networkmanager"
      ++ lists.optionals config.lonewanderer.services.virtualisation.libvirtd.enable ["kvm" "qemu" "libvirtd"];
  };
}
