args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.system.security.usbguard;
in {
  imports = [];

  options.lonewanderer.system.security.usbguard = {
    enable = mkEnableOption (mdDoc ''
      enable usbguard
    '');
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      presentControllerPolicy = "apply-policy";
      IPCAllowedGroups = ["wheel"];
      dbus.enable = true;
    };
  };
}
