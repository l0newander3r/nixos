args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.security;
in {
  imports = [
    (import ./security/keepassxc.nix args)
  ];

  options.lonewanderer.programs.security = {};

  config = {};
}
