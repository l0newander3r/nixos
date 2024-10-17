{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hypridle;
in {
  options.lonewanderer.programs.desktop.hypridle = {
    enable = mkEnableOption (mdDoc ''
      enable hypridle
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    # services.hypridle.enable = true;
  };
}
