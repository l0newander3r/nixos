{
  options,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.ags;
in {
  imports = [
    inputs.ags.homeManagerModules.ags
  ];

  options.lonewanderer.programs.desktop.ags = {
    enable = mkEnableOption (mdDoc ''
      enable Ags
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    lonewanderer.programs.desktop.hyprland = {
      widgets = mkDefault (getExe pkgs.ags);
    };

    programs.ags = {
      enable = true;
      extraPackages = with pkgs; [];
    };
  };
}
