{
  channels,
  inputs,
  ...
}: final: prev: {
  my_glslang = prev.glslang.overrideAttrs (finalAttrs: oldAttrs: {
    # Effectively revert the change seen here:
    # https://github.com/NixOS/nixpkgs/commit/c3948c21ef00fbf8ef02f3c2922e84ba72e8a62b#diff-21ee06ef20d156bedb03da22e28850e6043b04a00706a796e7e427fce44500e9R31
    cmakeFlags = [];
  });

  amdvlk = prev.amdvlk.override {
    glslang = final.my_glslang;
  };
}
