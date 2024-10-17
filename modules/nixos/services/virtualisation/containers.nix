{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.virtualisation.containers;
in {
  options.lonewanderer.services.virtualisation.containers = {
    enable = mkEnableOption (mdDoc ''
      enable container support
    '');
  };

  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;

    boot.kernel.sysctl."net.ipv4.ip_forward" = mkForce 1;

    boot.kernelModules = [
      "overlay"
      "nft_chain_nat"
      "nft_counter"
      "veth"
      "vxlan"
      "xt_addrtype"
      "xt_mark"
      "xt_MASQUERADE"
      "xt_multiport"
      "xt_nat"
    ];
  };
}
