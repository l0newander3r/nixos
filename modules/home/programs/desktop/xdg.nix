{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.xdg;
in {
  options.lonewanderer.programs.desktop.xdg = {
    enable = mkEnableOption (mdDoc ''
      enable XDG
    '');

    enableUserDirs = mkEnableOption (mdDoc ''
      Enable XDG user dirs
    '');

    folderNames = {
      desktop = mkOption {
        type = types.str;
        default = "/desktop";
        description =
          mdDoc ''
          '';
      };

      documents = mkOption {
        type = types.str;
        default = "/desktop/documents";
        description =
          mdDoc ''
          '';
      };

      download = mkOption {
        type = types.str;
        default = "/desktop/downloads";
        description =
          mdDoc ''
          '';
      };

      music = mkOption {
        type = types.str;
        default = "/media/music";
        description =
          mdDoc ''
          '';
      };

      pictures = mkOption {
        type = types.str;
        default = "/media/pictures";
        description =
          mdDoc ''
          '';
      };

      videos = mkOption {
        type = types.str;
        default = "/media/videos";
        description =
          mdDoc ''
          '';
      };

      templates = mkOption {
        type = types.str;
        default = "/templates";
        description =
          mdDoc ''
          '';
      };

      screenshots = mkOption {
        type = types.str;
        default = "/media/screenshots";
        description =
          mdDoc ''
          '';
      };

      misc = mkOption {
        type = types.str;
        default = "/desktop/misc";
        description =
          mdDoc ''
          '';
      };
    };
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    home.packages = with pkgs; [
      desktop-file-utils
    ];

    services.mpd.musicDirectory = mkDefault "${config.home.homeDirectory}${cfg.folderNames.music}";

    xdg.enable = mkForce true;

    xdg.mime = {
      enable = true;
    };

    xdg.mimeApps = {
      enable = true;
      # defaultApplications = {
      #   "application/pdf" = "";
      #   "application/x-extension-htm" = "";
      #   "application/x-extension-html" = "";
      #   "application/x-extension-shtml" = "";
      #   "application/x-extension-xht" = "";
      #   "application/x-extension-xhtml" = "";
      #   "application/xhtml+xml" = "";
      #   "application/xml" = "";
      #   "image/gif" = "";
      #   "image/jpeg" = "";
      #   "image/png" = "";
      #   "image/svg+xml" = "";
      #   "image/webp" = "";
      #   "text/csv" = "";
      #   "text/html" = "";
      #   "text/plain" = "";
      #   "text/x-c" = "";
      #   "text/x-diff" = "";
      #   "text/x-shellscript" = "";
      #   "x-scheme-handler/about" = "";
      #   "x-scheme-handler/chrome" = "";
      #   "x-scheme-handler/http" = "";
      #   "x-scheme-handler/https" = "";
      #   "x-scheme-handler/mailto" = "";
      #   "x-scheme-handler/unknown" = "";
      # };
    };

    xdg.userDirs = mkIf cfg.enableUserDirs {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}${cfg.folderNames.desktop}";
      documents = "${config.home.homeDirectory}${cfg.folderNames.documents}";
      download = "${config.home.homeDirectory}${cfg.folderNames.download}";
      music = "${config.home.homeDirectory}${cfg.folderNames.music}";
      pictures = "${config.home.homeDirectory}${cfg.folderNames.pictures}";
      videos = "${config.home.homeDirectory}${cfg.folderNames.videos}";
      templates = "${config.home.homeDirectory}${cfg.folderNames.templates}";
      publicShare = null;
      extraConfig = {
        XDG_MISC_DIR = "${config.home.homeDirectory}${cfg.folderNames.misc}";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}${cfg.folderNames.screenshots}";
      };
    };
  };
}
