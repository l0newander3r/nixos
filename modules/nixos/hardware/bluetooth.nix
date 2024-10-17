args @ {
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.bluetooth;
in {
  imports = [];

  options.lonewanderer.hardware.bluetooth = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');

    powerOnBoot = mkEnableOption (mdDoc ''
      Power on boot
    '');
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;
      settings.General = {
        Enable = "Source,Sink,Media";
        Experimental = true;
      };
    };

    services.pipewire.wireplumber.configPackages = mkIf config.lonewanderer.hardware.audio.enable [
      (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '')
    ];

    powerManagement.resumeCommands = ''
      ${pkgs.util-linux}/bin/rfkill block bluetooth
      ${pkgs.util-linux}/bin/rfkill unblock bluetooth
    '';
  };
}
