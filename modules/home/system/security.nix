args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security;
in {
  imports = [
    (import ./security/gnupg.nix args)
    (import ./security/u2f.nix args)
  ];

  options.lonewanderer.system.security = {};

  config = {
    home.packages = with pkgs; [
      age
      sops
      diceware
      pwgen
      rng-tools
    ];
  };
}
