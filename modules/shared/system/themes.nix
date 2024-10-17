args @ {
  lib,
  config,
  options,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.themes;

  opacityOption = mkOption {
    type = types.float;
    default = 1.0;
  };

  sizeOption = mkOption {
    type = types.number;
    default = 12;
  };
in {
  options.lonewanderer.system.themes = {
    enable = mkEnableOption (mdDoc ''
      enable custom theme settings
    '');

    theme = mkOption {
      type = types.str;
      default = "catppuccin-mocha";

      # Favorites:
      # atlas
      # blueforest
      # catppuccin-macchiato
      # sparky
      # spacemacs
      # spaceduck
      # unikitty-dark
      # unikitty-reversible
      # tokyo-city-dark
      # tokyo-city-terminal-dark
      # vice
    };

    image = mkOption {
      type = types.path;
      default = ./wallpapers/samurai.jpg;
    };

    fonts = {
      emoji.name = mkOption {
        type = types.str;
        default = "Noto Color Emoji";
      };

      emoji.package = mkOption {
        type = types.package;
        default = pkgs.noto-fonts-emoji;
      };

      monospace.name = mkOption {
        type = types.str;
        default = "JetBrainsMono Nerd Font";
      };

      monospace.package = mkOption {
        type = types.package;
        default = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };

      serif.name = mkOption {
        type = types.str;
        default = "Noto Serif";
      };

      serif.package = mkOption {
        type = types.package;
        default = pkgs.noto-fonts;
      };

      sansSerif.name = mkOption {
        type = types.str;
        default = "Noto Sans";
      };

      sansSerif.package = mkOption {
        type = types.package;
        default = pkgs.noto-fonts;
      };

      sizes = {
        applications = sizeOption;
        desktop = sizeOption;
        popups = sizeOption;
        terminal = sizeOption;
      };
    };

    opacity = {
      applications = opacityOption;
      desktop = opacityOption;
      popups = opacityOption;
      terminal = opacityOption;
    };

    cursor = {
      name = mkOption {
        type = types.str;
        default = "Catppuccin-Mocha-Dark-Cursors";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.catppuccin-cursors."mochaDark";
      };

      size = mkOption {
        type = types.int;
        default = 32;
      };
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = mkIf (cfg.theme != "") "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";
      cursor = cfg.cursor;
      fonts = cfg.fonts;
      opacity = cfg.opacity;
      image = cfg.image;
      imageScalingMode = "center";
      polarity = "either";
    };
  };
}
