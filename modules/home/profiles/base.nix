args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.base;
in {
  imports = [];

  options.lonewanderer.profiles.base = {
    enable = mkEnableOption (mdDoc ''
      enable base profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.system = {
      console.enable = mkDefault true;
      themes.enable = mkDefault true;
      security = {
        gnupg.enable = mkDefault true;
        u2f.enable = mkDefault true;
      };
    };

    lonewanderer.programs.tools = {
      bat.enable = true;
      btop.enable = true;
      lf.enable = true;
      tmux.enable = true;
    };
  };
}
