args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.tools;
in {
  imports = [
    (import ./tools/bat.nix args)
    (import ./tools/btop.nix args)
    (import ./tools/lf.nix args)
    (import ./tools/taskwarrior.nix args)
    (import ./tools/tmux.nix args)
  ];

  options.lonewanderer.programs.tools = {
    enable = mkEnableOption (mdDoc ''
      enable default tools
    '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      nix-tree
      deadnix
      vulnix
      statix
    ];

    programs.home-manager.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
