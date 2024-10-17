args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.developer;
in {
  imports = [];

  options.lonewanderer.profiles.developer = {
    enable = mkEnableOption (mdDoc ''
      enable developer profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.desktop.enable = true;

    lonewanderer.programs.editor.android-tools.enable = true;

    lonewanderer.services.virtualisation = {
      containerd.enable = true;
      libvirtd.enable = true;
    };

    # @todo check need.
    programs.nix-ld.enable = true;

    system.nixos.tags = ["developer"];
  };
}
