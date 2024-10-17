args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.services.sshd;
in {
  imports = [];

  options.lonewanderer.services.sshd = {
    enable = mkEnableOption (mdDoc ''
      enable sshd
    '');
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
