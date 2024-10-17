{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.desktop.greetd;

  runHyprLand = pkgs.writeShellScript "builder.sh" ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      mkdir -p ~/.cache
      exec ${getExe cfg.package} > $HOME/.cache/hyprland.log 2>&1
    fi
  '';
in {
  options.lonewanderer.programs.desktop.greetd = {
    enable = mkEnableOption (mdDoc ''
      enable greetd
    '');

    package = mkOption {
      type = types.package;
      default = pkgs.hyprland;
    };
  };

  config = mkIf (config.lonewanderer.programs.desktop.enable && cfg.enable) {
    environment.systemPackages = with pkgs; [greetd.tuigreet];

    security.pam.services.greetd = {
      u2fAuth = config.lonewanderer.system.security.u2f.enable;
      enableGnomeKeyring = true;
    };

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --cmd ${runHyprLand}";
        user = "greeter";
      };
    };
  };
}
