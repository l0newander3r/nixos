{
  config,
  lib,
  inputs,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.tools.btop;
  theme = config.lonewanderer.system.themes.theme;
in {
  options.lonewanderer.programs.tools.btop = {
    enable = mkEnableOption (mdDoc ''
      Enable btop
    '');
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        proc_tree = true;
      };
    };
  };
}
