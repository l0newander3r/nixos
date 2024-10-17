{
  config,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.security.keepassxc;
in {
  options.lonewanderer.programs.security.keepassxc = {
    enable = mkEnableOption (mdDoc ''
      Enable KeepassXC
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.programs.desktop.hyprland.vault = mkDefault "keepassxc";

    home.packages = with pkgs; [
      keepassxc
      git-credential-keepassxc
    ];

    # https://github.com/Frederick888/git-credential-keepassxc
    programs.git.extraConfig = {
      credential.helper = "keepassxc --git-groups";
    };
  };
}
