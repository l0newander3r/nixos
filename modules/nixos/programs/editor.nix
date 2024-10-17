args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor;
in {
  imports = [
    (import ./editor/android-tools.nix args)
  ];

  options.lonewanderer.programs.editor = {};

  config = {};
}
