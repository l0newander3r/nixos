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
    (import ./editor/android-studio.nix args)
    (import ./editor/intellij-idea.nix args)
    (import ./editor/neovim.nix args)
    (import ./editor/vscodium.nix args)
  ];

  options.lonewanderer.programs.editor = {};

  config = {};
}
