args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs;
in {
  imports = [
    (import ./desktop.nix args)
    (import ./editor.nix args)
  ];

  options.lonewanderer.programs = {};

  config = {};
}
