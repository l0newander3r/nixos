args @ {...}: {
  imports = [
    (import ../hardware/default.nix args)
    (import ../profiles/default.nix args)
    (import ../programs/default.nix args)
    (import ../services/default.nix args)
    (import ../system/default.nix args)
  ];
}
