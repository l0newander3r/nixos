args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.wifi;
in {
  imports = [];

  options.lonewanderer.hardware.wifi = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');
  };

  config = mkIf cfg.enable {
    environment.etc."modprobe.d/iwlwifi.conf".text = ''
      options iwlwifi uapsd_disable=1
      options iwlwifi swcrypto=0
      options iwlwifi bt_coex_active=0
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
    '';
  };
}
