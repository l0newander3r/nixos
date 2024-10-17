args @ {
  lib,
  config,
  inputs,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.boot.lanzaboote;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.lonewanderer.system.boot.lanzaboote = {
    enable = mkEnableOption (mdDoc ''
      enable Lanzaboote
    '');
  };

  config = mkIf (config.lonewanderer.system.boot.enable && cfg.enable) {
    boot.bootspec.enableValidation = true;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
