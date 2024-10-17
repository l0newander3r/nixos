{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.kubernetes;
  fullCNIPlugins = pkgs.buildEnv {
    name = "full-cni";
    paths = with pkgs; [
      cni-plugins
      cni-plugin-flannel
    ];
  };
in {
  options.lonewanderer.services.virtualisation.kubernetes = {
    enable = mkEnableOption (mdDoc ''
      Enable Kubernetes
    '');

    openFirewall = mkEnableOption (mdDoc ''
      Enable Kubernetes
    '');
  };

  config = mkIf (config.lonewanderer.services.virtualisation.containerd.enable && cfg.enable) {
    system.activationScripts.makeRancherK3sStorageDir = lib.stringAfter ["var"] ''
      mkdir -p /var/lib/rancher/k3s/storage
    '';

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [6443];
    networking.firewall.allowedUDPPorts = mkIf cfg.openFirewall [8472];

    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--container-runtime-endpoint unix:///run/containerd/containerd.sock"
      ];
    };

    virtualisation.containerd.settings.plugins = {
      "io.containerd.grpc.v1.cri".cni = {
        bin_dir = "${fullCNIPlugins}/bin";
        conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
      };
    };
  };
}
