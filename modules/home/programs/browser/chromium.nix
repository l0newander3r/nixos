{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.browser.chromium;
in {
  options.lonewanderer.programs.browser.chromium = {
    enable = mkEnableOption (mdDoc ''
      Enable the Chromium web browser
    '');

    package = mkOption {
      type = types.package;
      default = pkgs.chromium;
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = cfg.package;
      commandLineArgs = [
        "--password-store=gnome-libsecret"
        "--ozone-platform-hint=wayland"
        "--gtk-version=4"
        "--ignore-gpu-blocklist"
        "--enable-features=TouchpadOverscrollHistoryNavigation"
        "--enable-wayland-ime"
      ];
      extensions = [
        {id = "bcjindcccaagfpapjjmafapmmgkkhgoa";} # JSON Formatter
        {id = "oboonakemofpalcgghocfoadofidjkkk";} # KeepassXC
        {id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";} # Privacy Badger
        {id = "gmbmikajjgmnabiglmofipeabaddhgne";} # Save to Google Drive
        {id = "lpcaedmchfhocbbapmcbpinfpgnhiddi";} # Save to Google Keep
      ];
    };
  };
}
