args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.server;
in {
  imports = [];

  options.lonewanderer.profiles.server = {
    enable = mkEnableOption (mdDoc ''
      enable server profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.base.enable = true;

    system.nixos.tags = ["server"];
  };
}
