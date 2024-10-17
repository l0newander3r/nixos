{
  config,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.media.mpd;
in {
  options.lonewanderer.programs.media.mpd = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mpc-cli
    ];

    services.mpd = {
      enable = true;
      extraConfig = ''
        auto_update "yes"

        audio_output {
          type  "pipewire"
          name  "PipeWire Sound Server"
        }

        audio_output {
          type        "httpd"
          name        "HTTPD Sound Server"
          encoder     "lame"
          port        "8000"
          bitrate     "320"
          format      "44100:16:1"
          max_clients "0"
        }
      '';
    };

    services.mpd-mpris = {
      enable = true;
    };
  };
}
