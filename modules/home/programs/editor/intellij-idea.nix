{
  config,
  inputs,
  lib,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor.intellij-idea;
in {
  options.lonewanderer.programs.editor.intellij-idea = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config =
    mkIf cfg.enable {
    };
}
