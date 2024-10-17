args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security;
in {
  imports = [
    (import ./security/backup.nix args)
    (import ./security/clamav.nix args)
    (import ./security/dnscrypt.nix args)
    (import ./security/encryption.nix args)
    (import ./security/firewall.nix args)
    (import ./security/gnupg.nix args)
    (import ./security/u2f.nix args)
    (import ./security/usbguard.nix args)
  ];

  options.lonewanderer.system.security = {};

  config = {
    nix.settings = with config.lonewanderer.system.user; {
      allowed-users = mkDefault ["@wheel"];
      trusted-users = mkDefault ["@wheel"];
    };

    security.sudo.enable = mkDefault false;

    security.doas = {
      enable = mkDefault true;
      extraRules = [
        {
          groups = ["wheel"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
