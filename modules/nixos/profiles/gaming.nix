args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.gaming;
in {
  imports = [];

  options.lonewanderer.profiles.gaming = {
    enable = mkEnableOption (mdDoc ''
      enable gaming profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.desktop.enable = true;

    system.nixos.tags = ["gaming"];
  };
}
