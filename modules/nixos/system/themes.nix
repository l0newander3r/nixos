args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.themes;

  tty = {
    ninja = [
      "vt.default_red=36,237,166,238,138,245,139,184,91,237,166,238,138,245,139,165"
      "vt.default_grn=39,135,218,212,173,189,213,192,96,135,218,212,173,189,213,173"
      "vt.default_blu=58,150,149,159,244,230,202,224,120,150,149,159,244,230,202,203"
    ];
    samurai = [
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };
in {
  imports = [];

  options.lonewanderer.system.themes = {
    enable = mkEnableOption (mdDoc ''
      enable custom theme settings
    '');

    theme = mkOption {
      type = types.enum ["samurai" "ninja"];
      default = "samurai";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = tty."${cfg.theme}";
  };
}
