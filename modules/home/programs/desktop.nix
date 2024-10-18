args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop;
in {
  imports = [
    (import ./desktop/ags.nix args)
    (import ./desktop/gtk.nix args)
    (import ./desktop/hyprpaper.nix args)
    (import ./desktop/hyprland.nix args)
    (import ./desktop/hyprlock.nix args)
    (import ./desktop/hypridle.nix args)
    (import ./desktop/hyprpanel.nix args)
    (import ./desktop/xdg.nix args)
  ];

  options.lonewanderer.programs.desktop = {
    enable = mkEnableOption (mdDoc ''
      Enable the desktop view
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.system.security.gnupg.pinentryPackage = pkgs.pinentry-gnome3;

    home.packages = with pkgs; [
      nautilus
      wl-clipboard
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    services.wlsunset = {
      enable = true;
      gamma = 1.0;
      sunrise = mkDefault "06:30";
      sunset = mkDefault "21:30";
    };

    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
      ];
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = getExe pkgs.kitty;
          prompt = ">> ";
          layer = "overlay";
        };

        border = {
          radius = 10;
          width = 2;
        };

        dmenu = {
          exit-immediately-if-empty = "yes";
        };
      };
    };
  };
}
