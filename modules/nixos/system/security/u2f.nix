args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.u2f;
in {
  imports = [];

  options.lonewanderer.system.security.u2f = {
    enable = mkEnableOption (mdDoc ''
      enable U2F settings
    '');

    origin = mkOption {
      type = types.str;
      default = "pam://yubikey";
    };

    u2fControl = mkOption {
      type = types.enum ["required" "sufficient"];
      default = "sufficient";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.luks.devices."00-key".crypttabExtraOpts = ["fido2-device=auto"];

    programs.yubikey-touch-detector = {
      enable = true;
      libnotify = config.lonewanderer.programs.desktop.enable;
    };

    security.pam.services = {
      login.u2fAuth = true;
      doas.u2fAuth = true;
      polkit-1.u2fAuth = true;
    };

    security.pam.u2f = {
      control = cfg.u2fControl;
      enable = true;
      settings.cue = true;
      settings.origin = cfg.origin;
    };

    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function (action, subject) {
          if (
            (action.id == "org.debian.pcsc-lite.access_pcsc" ||
            action.id == "org.debian.pcsc-lite.access_card") &&
            subject.isInGroup("wheel")
          ) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    services.pcscd.enable = true;

    services.udev.packages = [pkgs.yubikey-personalization];
    # services.udev.extraRules = ''
    #   ACTION=="remove",\
    #    ENV{ID_BUS}=="usb",\
    #    ENV{ID_MODEL_ID}=="0407",\
    #    ENV{ID_VENDOR_ID}=="1050",\
    #    ENV{ID_VENDOR}=="Yubico",\
    #    ENV{MOD_ALIAS}=="",\
    #    ENV{INTERFACE}=="",\
    #    RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
    # '';
  };
}
