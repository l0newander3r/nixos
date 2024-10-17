{
  config,
  lib,
  inputs,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.tools.bat;
  theme = config.lonewanderer.system.themes.theme;
in {
  options.lonewanderer.programs.tools.bat = {
    enable = mkEnableOption (mdDoc ''
      Enable bat
    '');
  };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases."cat" = "bat --paging=never --style=plain";

    programs.bat = {
      enable = true;
    };
  };
}
