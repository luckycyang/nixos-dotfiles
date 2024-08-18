{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.terminal.starship;
in {
  options.modules.terminal.starship = {enable = mkEnableOption "Starship for bash";};
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
