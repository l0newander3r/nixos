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

    keys = mkOption {
      type = types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/Yubico/u2f_keys" = {
      source = pkgs.writeText "u2f-mappings" cfg.keys;
    };

    home.packages = with pkgs;
      [
        yubikey-manager
        yubikey-personalization
      ]
      ++ lists.optionals config.lonewanderer.profiles.desktop.enable [
        yubikey-personalization-gui
      ];
  };
}
