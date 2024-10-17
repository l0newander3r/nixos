{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.hyprlock;
in {
  options.lonewanderer.programs.desktop.hyprlock = {
    enable = mkEnableOption (mdDoc ''
      enable hyprland
    '');
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    lonewanderer.programs.desktop.hyprland.enable = mkForce true;

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = false;
          fractional_scaling = 2;
          grace = 10;
          hide_cursor = false;
          ignore_empty_input = false;
          no_fade_in = false;
          no_fade_out = false;
          text_trim = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
