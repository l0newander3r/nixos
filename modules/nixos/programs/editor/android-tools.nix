{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor.android-tools;
in {
  options.lonewanderer.programs.editor.android-tools = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
  };
}
