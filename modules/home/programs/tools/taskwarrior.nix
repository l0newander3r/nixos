{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.lonewanderer.programs.tools.taskwarrior;
in {
  options.lonewanderer.programs.tools.taskwarrior = {
    enable = mkEnableOption (mdDoc ''
      Enable Taskwarrior support
    '');
  };

  config = mkIf cfg.enable {
    programs.taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      config = {
        confirmation = false;
        report.minimal.filter = "status:pending";
        report.active.columns = ["id" "start" "entry.age" "priority" "project" "due" "description"];
        report.active.labels = ["ID" "Started" "Age" "Priority" "Project" "Due" "Description"];
      };
      colorTheme = "dark-blue-256";
      extraConfig = ''
        alias t="task"
      '';
    };
  };
}
