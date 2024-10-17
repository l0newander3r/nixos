args @ {
  lib,
  config,
  modulesPath,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system;
in {
  imports = [
    (modulesPath + "/profiles/base.nix")

    (import ./boot.nix args)
    (import ./console.nix args)
    (import ./filesystem.nix args)
    (import ./fonts.nix args)
    (import ./kernel.nix args)
    (import ./locale.nix args)
    (import ./security.nix args)
    (import ./themes.nix args)
    (import ./upgrade.nix args)
    (import ./user.nix args)
  ];

  options.lonewanderer.system = {
    domain = mkOption {
      type = types.str;
      description = mdDoc ''
        Some text
      '';
    };

    hostId = mkOption {
      type = types.str;
      description = mdDoc ''
        Some other text
      '';
    };
  };

  config = {
    networking = {
      domain = cfg.domain;
      hostId = cfg.hostId;
    };

    nix.gc = {
      automatic = mkDefault true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nix.optimise.automatic = mkDefault true;

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
