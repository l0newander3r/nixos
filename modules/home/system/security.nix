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
      # Sops support
      age
      sops
      ssh-to-pgp

      # Password generation
      diceware
      pwgen
      rng-tools
    ];
  };
}
