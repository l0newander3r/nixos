args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.profiles.developer;
in {
  imports = [];

  options.lonewanderer.profiles.developer = {
    enable = mkEnableOption (mdDoc ''
      enable developer profile
    '');
  };

  config = mkIf cfg.enable {
    lonewanderer.profiles.desktop.enable = true;

    home.sessionVariables = {
      GOPATH = "$HOME/.local/go";
      PYTHON_KEYRING_BACKEND = "keyring.backends.null.Keyring";
    };

    home.packages = with pkgs; [
      alejandra
    ];

    home.sessionPath = [
      "$HOME/.local/go/bin"
    ];

    lonewanderer.programs.editor = {
      # android-studio.enable = true;
      intellij-idea.enable = true;
      vscodium.enable = true;
    };

    lonewanderer.services.virtualisation = {
      kubernetes.enable = true;
      libvirtd.enable = true;
    };
  };
}
