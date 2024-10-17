args @ {
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.browser;
in {
  imports = [
    (import ./browser/chromium.nix args)
  ];

  options.lonewanderer.programs.browser = {};

  config = {};
}
