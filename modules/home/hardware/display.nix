args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.display;
in {
  imports = [];

  options.lonewanderer.hardware.display = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');

    monitors = mkOption {
      default = {};
      description =
        mdDoc ''
        '';

      type = with types;
        attrsOf (submodule (
          {
            config,
            name,
            ...
          }: {
            options = {
              alias = mkOption {
                example = 1;
                type = types.int;
                default = 1;
                description = mdDoc "";
              };

              name = mkOption {
                visible = false;
                default = name;
                example = "DP-1";
                type = types.str;
                description = mdDoc "Name of the monitor.";
              };

              resolution = mkOption {
                example = "3840x2160@60";
                type = types.str;
                default = "preferred";
                description = mdDoc "";
              };

              position = mkOption {
                example = "0x2160";
                type = types.str;
                default = "auto";
                description = mdDoc "";
              };

              scaling = mkOption {
                example = 2.0;
                type = types.float;
                default = 1;
                description = mdDoc "";
              };

              extraParams = mkOption {
                example = "bitdepth,10,vrr,2";
                type = types.str;
                default = "";
                description = mdDoc "";
              };
            };
          }
        ));
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
    ];
  };
}
