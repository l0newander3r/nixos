args @ {
  config,
  options,
  lib,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation;
in {
  imports = [
    (import ./virtualisation/containers.nix args)
    (import ./virtualisation/containerd.nix args)
    (import ./virtualisation/docker.nix args)
    (import ./virtualisation/kubernetes.nix args)
    (import ./virtualisation/libvirtd.nix args)
    (import ./virtualisation/podman.nix args)
  ];

  options.lonewanderer.services.virtualisation = {};

  config = {};
}
