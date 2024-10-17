args @ {lib, ...}:
with lib; {
  imports = [
    (import ./browser.nix args)
    (import ./desktop.nix args)
    (import ./editor.nix args)
    (import ./media.nix args)
    (import ./security.nix args)
    (import ./terminal.nix args)
    (import ./tools.nix args)
  ];
}
