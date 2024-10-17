args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.hardware.audio;
in {
  imports = [
    (import ./audio/focusrite.nix args)
  ];

  options.lonewanderer.hardware.audio = {
    enable = mkEnableOption (mdDoc ''
      enable
    '');

    enableAlsa = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc ''
        Enable Alsa audio support in the kernel.
      '';
    };

    enableJack = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Enable Jack audio support in the kernel.
      '';
    };

    enableLowLatencyMode = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc ''
        Enable low-latency audio support in the kernel.
      '';
    };

    enablePulseAudio = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc ''
        Enable Alsa audio support in the kernel.
      '';
    };

    enableRealtimeKit = mkOption {
      type = with types; bool;
      default = true;
      description = mdDoc ''
        Whether to enable the RealtimeKit system service, which hands out realtime scheduling priority to user processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
      '';
    };
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = mkForce false;

    security.rtkit.enable = cfg.enableRealtimeKit;

    services.pipewire = {
      enable = true;
      alsa.enable = cfg.enableAlsa;
      jack.enable = cfg.enableJack;
      pulse.enable = cfg.enablePulseAudio;

      extraConfig.pipewire."92-low-latency" = mkIf (cfg.enablePulseAudio && cfg.enableLowLatencyMode) {
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 32;
        };
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
    };
  };
}
