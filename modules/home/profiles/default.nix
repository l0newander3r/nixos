args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles;
in {
  imports = [
    (import ./base.nix args)
    (import ./desktop.nix args)
    (import ./developer.nix args)
    (import ./gaming.nix args)
    (import ./productivity.nix args)
    (import ./server.nix args)
  ];

  options.lonewanderer.profiles = {};

  config = {};
}
