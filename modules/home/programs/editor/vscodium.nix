{
  config,
  inputs,
  lib,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.editor.vscodium;
in {
  options.lonewanderer.programs.editor.vscodium = {
    enable =
      mkEnableOption (mdDoc ''
        '');
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      package = pkgs.vscodium;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        editorconfig.editorconfig
        file-icons.file-icons
        golang.go
        graphql.vscode-graphql
        hashicorp.terraform
        kamadorueda.alejandra
        ms-python.python
        ms-vscode.makefile-tools
        redhat.java
        redhat.vscode-xml
        redhat.vscode-yaml
        timonwong.shellcheck
      ];

      userSettings = {
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "[scss]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };
        "alejandra.program" = "alejandra";
        "cloudcode.duetAI.project" = "personal-klopper-5xh2";
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.excludeGitIgnore" = true;
        "files.autoSave" = "onFocusChange";
        "python.testing.pytestEnabled" = true;
        "testing.coverageToolbarEnabled" = true;
        "window.titleBarStyle" = "custom";
        "testing.coverageBarThresholds" = {
          "red" = 0;
          "yellow" = 60;
          "green" = 90;
        };
      };
    };
  };
}
