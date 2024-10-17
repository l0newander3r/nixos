args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services;
in {
  imports = [
    (import ./flatpak.nix args)
    (import ./sshd.nix args)
    (import ./virtualisation.nix args)
  ];

  options.lonewanderer.services = {};

  config = {};
}
