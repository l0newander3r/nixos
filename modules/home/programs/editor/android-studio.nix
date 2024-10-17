{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor.android-studio;
in {
  options.lonewanderer.programs.editor.android-studio = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [android-studio android-tools];
  };
}
