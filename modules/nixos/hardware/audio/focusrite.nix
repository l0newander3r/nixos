{
  options,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.audio.focusrite;
in {
  options.lonewanderer.hardware.audio.focusrite = {
    enable = mkEnableOption (mdDoc ''
      Enable Focusrite kernel module setting
    '');
  };

  config = mkIf (config.lonewanderer.hardware.audio.enable && cfg.enable) {
    environment.etc."modprobe.d/focusrite.conf".text = ''
      options snd_usb_audio vid=0x1235 pid=0x8213 device_setup=1
    '';
  };
}
