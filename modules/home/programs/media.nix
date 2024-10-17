args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.media;
in {
  imports = [
    (import ./media/mpd.nix args)
    (import ./media/mpv.nix args)
  ];

  options.lonewanderer.programs.media = {};

  config = {};
}
