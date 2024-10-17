args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.fonts;
in {
  imports = [];

  options.lonewanderer.system.fonts = {
    enable = mkEnableOption (mdDoc ''
      enable custom font settings
    '');
  };

  config = mkIf cfg.enable {
    fonts.enableDefaultPackages = mkDefault true;
    fonts.fontDir.enable = mkDefault true;

    fonts.fontconfig = {
      enable = mkDefault true;
    };

    fonts.packages = with pkgs;
      mkIf config.lonewanderer.profiles.desktop.enable [
        corefonts
        nerdfonts
      ];
  };
}
