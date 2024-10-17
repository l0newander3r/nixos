args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.user;
in {
  imports = [];

  options.lonewanderer.system.user = {
    github = mkOption {
      type = types.str;
      default = "";
      description =
        mdDoc ''
        '';
    };

    signingKey = mkOption {
      type = types.str;
      default = "";
      description =
        mdDoc ''
        '';
    };

    name = mkOption {
      type = types.str;
      default = config.home.username;
      description =
        mdDoc ''
        '';
    };

    email = mkOption {
      type = types.str;
      description =
        mdDoc ''
        '';
    };
  };

  config = {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      signing = mkIf (cfg.signingKey != "") {
        key = cfg.signingKey;
        signByDefault = true;
      };
      extraConfig = {
        core.whitespace = "trailing-space,space-before-tab";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };
  };
}
