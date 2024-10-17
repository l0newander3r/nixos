args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.productivity;
in {
  imports = [];

  options.lonewanderer.profiles.productivity = {
    enable = mkEnableOption (mdDoc ''
      enable productivity profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.desktop.enable = true;

    system.nixos.tags = ["productivity"];
  };
}
