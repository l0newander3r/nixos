args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.terminal;
in {
  imports = [
    (import ./terminal/kitty.nix args)
  ];

  options.lonewanderer.programs.terminal = {};

  config = {};
}
