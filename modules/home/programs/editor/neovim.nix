{
  config,
  lib,
  inputs,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor.neovim;
in {
  options.lonewanderer.programs.editor.neovim = {
    enable = mkEnableOption (mdDoc ''
      Enable neovim
    '');
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        zoxide-vim
      ];
    };

    programs.zoxide = {
      enable = true;
    };
  };
}
