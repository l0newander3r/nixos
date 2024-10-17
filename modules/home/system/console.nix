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
  };

  config = mkIf cfg.enable {
    programs.command-not-found.enable = true;

    programs.ssh.extraConfig = ''
      Host github.com
        ForwardAgent yes

      Host *
        ServerAliveInterval 60
        Compression yes
    '';

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      enableVteIntegration = config.lonewanderer.profiles.desktop.enable;
      shellAliases = {
        erase = "shred -f -n 5 -u -z";
      };
      zplug = {
        enable = true;
        plugins = [
          {name = "nix-community/nix-zsh-completions";}
          {
            name = "plugins/command-not-found";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/cp";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/direnv";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/encode64";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/git";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/pre-commit";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/themes";
            tags = [from:oh-my-zsh];
          }
          {
            name = "plugins/themes";
            tags = [from:oh-my-zsh];
          }
          {name = "zsh-users/zaw";}
          {name = "zsh-users/zsh-completions";}
          {name = "zsh-users/zsh-history-substring-search";}
          {name = "zsh-users/zsh-syntax-highlighting";}
        ];
      };
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = ["--group-directories-first"];
      icons = "auto";
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux = {
        enableShellIntegration = true;
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # z foo              # cd into highest ranked directory matching foo
    # z foo bar          # cd into highest ranked directory matching foo and bar
    # z foo /            # cd into a subdirectory starting with foo
    # z ~/foo            # z also works like a regular cd command
    # z foo/             # cd into relative path
    # z ..               # cd one level up
    # z -                # cd into previous directory
    # zi foo             # cd with interactive selection (using fzf)
    # z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
