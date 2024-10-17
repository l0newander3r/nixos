args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware;
in {
  imports = [
    (import ./audio.nix args)
    (import ./bluetooth.nix args)
    (import ./display.nix args)
    (import ./network.nix args)
    (import ./security.nix args)
    (import ./usb.nix args)
    (import ./video.nix args)
    (import ./webcam.nix args)
    (import ./wifi.nix args)
  ];

  options.lonewanderer.hardware = {
    enableAllFirmware = mkEnableOption (mdDoc ''
      Enable all firmware
    '');

    enableFirmwareUpdate = mkEnableOption (mdDoc ''
      Enable firmware upgrade with fwupd and CPU microcode updates.
    '');

    platform = mkOption {
      type = with types; str;
      description = mdDoc ''
        Set the platform (amd / intel)
      '';
    };
  };

  config = {
    hardware.enableAllFirmware = cfg.enableAllFirmware;
    hardware.cpu."${cfg.platform}".updateMicrocode = cfg.enableFirmwareUpdate;
    services.fwupd.enable = cfg.enableFirmwareUpdate;
  };
}
