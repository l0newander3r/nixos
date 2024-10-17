args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.locale;
in {
  options.lonewanderer.system.locale = {
    defaultLocale = mkOption {
      type = with types; str;
      default = "en_US.UTF-8";
      description =
        mdDoc ''
        '';
    };

    extraLocale = mkOption {
      type = with types; str;
      default = "nl_NL.UTF-8";
      description =
        mdDoc ''
        '';
    };

    supportedLocales = mkOption {
      type = with types; listOf str;
      default = [
        "en_US.UTF-8/UTF-8"
        "nl_NL.UTF-8/UTF-8"
      ];
    };
  };

  config = {
    i18n.supportedLocales = cfg.supportedLocales;

    i18n.defaultLocale = cfg.defaultLocale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.extraLocale;
      LC_IDENTIFICATION = cfg.extraLocale;
      LC_MEASUREMENT = cfg.extraLocale;
      LC_MONETARY = cfg.extraLocale;
      LC_NAME = cfg.extraLocale;
      LC_NUMERIC = cfg.extraLocale;
      LC_PAPER = cfg.extraLocale;
      LC_TELEPHONE = cfg.extraLocale;
      LC_TIME = cfg.extraLocale;
    };
  };
}
