{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.tools.tmux;
in {
  options.lonewanderer.programs.tools.tmux = {
    enable = mkEnableOption (mdDoc ''
      Tmux
    '');
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = getExe pkgs.zsh;
      terminal = "tmux-256color";
      historyLimit = 100000;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '10'
          '';
        }
      ];
      extraConfig = ''
      '';
    };
  };
}
