{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hypridle;
in {
  options.lonewanderer.programs.desktop.hypridle = {
    enable = mkEnableOption (mdDoc ''
      enable hypridle
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    home.packages = with pkgs; [
      brightnessctl
    ];

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 60;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 60;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }
          {
            timeout = 180;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
