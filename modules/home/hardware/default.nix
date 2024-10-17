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
  };

  config = {
  };
}
