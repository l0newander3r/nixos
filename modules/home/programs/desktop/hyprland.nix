{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprland;
  theme = config.lonewanderer.system.themes;

  monitors = attrsets.mapAttrsToList (k: v: v) (
    builtins.mapAttrs (name: value:
      builtins.concatStringsSep "," [
        name
        value.resolution
        (toString value.position)
        (toString value.scaling)
        value.extraParams
      ])
    config.lonewanderer.hardware.display.monitors
  );
in {
  options.lonewanderer.programs.desktop.hyprland = {
    enable = mkEnableOption (mdDoc ''
      enable hyprland
    '');

    browser = mkOption {
      type = types.str;
      default = "chromium";
    };

    editor = mkOption {
      type = types.str;
      default = "neovim";
    };

    run = mkOption {
      type = types.str;
      default = "fuzzel";
    };

    terminal = mkOption {
      type = types.str;
      default = "kitty";
    };

    vault = mkOption {
      type = types.str;
      default = "keepassxc";
    };

    widgets = mkOption {
      type = types.str;
      default = "";
    };

    windowrule = mkOption {
      type = with types; listOf str;
      default = [];
    };

    windowrulev2 = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    xdg.configFile."hypr" = {
      source = ./etc/hyprland;
      recursive = true;
    };

    home.sessionVariables = {
      # Hyprland specific
      HYPRLAND_TRACE = 1; # Enables more verbose logging.
      HYPRLAND_NO_RT = 1; # Disables realtime priority setting by Hyprland.
      HYPRLAND_NO_SD_NOTIFY = 1; # If systemd, disables the sd_notify calls.
      HYPRLAND_NO_SD_VARS = 1; # Disables management of variables in systemd and dbus activation environments.

      # Aquamarine
      AQ_TRACE = 1; #  Enables more verbose logging.
      AQ_DRM_DEVICES = ""; # Set an explicit list of DRM devices (GPUs) to use.
      AQ_MGPU_NO_EXPLICIT = 1; # Disables explicit syncing on mgpu buffers
      AQ_NO_MODIFIERS = 1; # Disables modifiers for DRM buffers

      XDG_SESSION_TYPE = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      sourceFirst = true;

      extraConfig = ''
        source = ~/.config/hypr/display.conf
        source = ~/.config/hypr/settings.conf
        source = ~/.config/hypr/rules.conf
        source = ~/.config/hypr/bindings.conf
      '';

      plugins = with pkgs.hyprlandPlugins; [
        hyprbars
        hyprexpo
        hyprfocus
      ];

      settings = {
        "$mod" = "SUPER";
        "$alt" = "SHIFT SUPER";
        "$wm" = "CTRL SUPER";

        "$browser" = cfg.browser;
        "$editor" = cfg.editor;
        "$run" = cfg.run;
        "$terminal" = cfg.terminal;
        "$vault" = cfg.vault;
        "$lock" = "loginctl lock-session";
        "$widgets" = cfg.widgets;

        windowrule = cfg.windowrule;
        windowrulev2 = cfg.windowrulev2;

        env =
          [
            # Toolkit Backend
            "GDK_BACKEND,wayland,x11"
            "QT_QPA_PLATFORM,wayland;xcb"
            "SDL_VIDEODRIVER,wayland"
            "CLUTTER_BACKEND,wayland"

            # XDG
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"

            # QT
            "QT_AUTO_SCREEN_SCALE_FACTOR,1"
            "QT_QPA_PLATFORM,wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "QT_QPA_PLATFORMTHEME,qt5ct"

            # HiDPI XWayland
            "GDK_SCALE,1.2"
            "XCURSOR_SIZE,32"
          ]
          ++ lists.optionals config.lonewanderer.hardware.video.nvidia.enable [
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "LIBVA_DRIVER_NAME,nvidia" # Hardware acceleration on NVIDIA GPUs
            "__GL_GSYNC_ALLOWED=1" # Controls if G-Sync capable monitors should use Variable Refresh Rate (VRR)
            "__GL_VRR_ALLOWED=0" # Controls if Adaptive Sync should be used. Recommended to set as “0”
            "AQ_NO_ATOMIC,0" # use legacy DRM interface instead of atomic mode setting. NOT recommended.
          ];

        source = [];

        monitor = monitors;

        exec-once = [
          "hyprctl setcursor ${theme.cursor.name} ${toString theme.cursor.size}"
          "$widgets"
          "$terminal"
          "$browser"
          "$vault"
          "$editor"
        ];
      };
    };
  };
}
