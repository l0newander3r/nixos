{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.terminal.kitty;
in {
  options.lonewanderer.programs.terminal.kitty = {
    enable = mkEnableOption (mdDoc ''
      enable kitty
    '');

    startupSession = mkOption {
      type = types.str;
      default = "none";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neofetch
    ];

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      keybindings = {
        "ctrl+n" = "launch --cwd=current --location=neighbor";
        "ctrl+f" = "launch --cwd=current --location=first";
        "kitty_mod+n" = "new_os_window_with_cwd";
        "kitty_mod+t" = "launch --cwd=current --type=tab";
      };
      settings = {
        startup_session = cfg.startupSession;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
      };
    };
  };
}
