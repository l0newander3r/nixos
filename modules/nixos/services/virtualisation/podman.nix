{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.podman;
in {
  options.lonewanderer.services.virtualisation.podman = {
    enable = mkEnableOption (mdDoc ''
      Enable podman
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.services.virtualisation.containers.enable = mkForce true;

    virtualisation.podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
