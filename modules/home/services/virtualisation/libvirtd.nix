{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.libvirtd;
in {
  options.lonewanderer.services.virtualisation.libvirtd = {
    enable = mkEnableOption (mdDoc ''
      Enable Qemu
    '');
  };

  config = mkIf cfg.enable {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    home.packages = with pkgs; [
      quickemu
      spice
      spice-gtk
      spice-protocol
      virt-manager
      virt-viewer
      win-virtio
      win-spice
    ];
  };
}
