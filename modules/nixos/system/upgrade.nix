args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.upgrade;
in {
  imports = [];

  options.lonewanderer.system.upgrade = {
    enable = mkEnableOption (mdDoc ''
      enable auto upgrade settings
    '');
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      operation = "switch";
      flake = "/etc/nixos";
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
      ];
      dates = "weekly";
    };
  };
}
