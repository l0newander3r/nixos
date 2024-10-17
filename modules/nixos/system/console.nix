args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.console;
in {
  imports = [];

  options.lonewanderer.system.console = {
    enable = mkEnableOption (mdDoc ''
      enable custom console settings
    '');

    font = mkOption {
      type = types.str;
      default = "ter-powerline-v32b";
    };

    packages = mkOption {
      type = types.listOf (types.package);
      default = [
        pkgs.powerline-fonts
      ];
    };
  };

  config = mkIf cfg.enable {
    console = {
      earlySetup = true;
      font = cfg.font;
      packages = cfg.packages;
    };

    programs.zsh = {
      enable = true;
      vteIntegration = config.lonewanderer.programs.desktop.enable;
    };

    users.defaultUserShell = pkgs.zsh;
  };
}
