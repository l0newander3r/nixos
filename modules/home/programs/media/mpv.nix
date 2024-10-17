{
  config,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.media.mpv;
in {
  options.lonewanderer.programs.media.mpv = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
      ];
    };
  };
}
