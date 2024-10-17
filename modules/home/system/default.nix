args @ {
  lib,
  config,
  inputs,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system;
in {
  imports = [
    (import ./console.nix args)
    (import ./security.nix args)
    (import ./themes.nix args)
    (import ./user.nix args)
  ];

  options.lonewanderer.system = {};

  config = {
  };
}
