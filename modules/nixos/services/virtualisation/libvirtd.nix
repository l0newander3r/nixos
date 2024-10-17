{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.libvirtd;
  pciPassthroughIDs = strings.concatStringsSep "," cfg.pciPassthroughIDs;
  platform = config.lonewanderer.hardware.platform;
in {
  options.lonewanderer.services.virtualisation.libvirtd = {
    enable = mkEnableOption (mdDoc ''
      Enable Qemu
    '');

    enableVfio = mkEnableOption (mdDoc ''
      Enable VFIO
    '');

    enableOVMF =
      mkEnableOption
      (mdDoc ''
        Enable OVMF
      '')
      // {default = true;};

    pciPassthroughIDs = mkOption {
      type = with types; listOf str;
      default = [];
      description = mdDoc ''
        List of PCI ID's to pass through to the VM, useful for running Windows on
        a dedicated GPU.
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.extraModprobeConfig = mkIf (cfg.enableVfio && cfg.pciPassthroughIDs != []) ''
      options vfio-pci ids=${pciPassthroughIDs}";
    '';

    boot.kernelModules =
      ["kvm-${platform}"]
      ++ lists.optionals cfg.enableVfio ["vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd"];

    virtualisation.spiceUSBRedirection.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      qemu.ovmf.enable = cfg.enableOVMF;
      qemu.ovmf.packages = [pkgs.OVMFFull.fd];
      qemu.swtpm.enable = true;
    };
  };
}
