{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.alacritty;
in {
  options.modules.terminal.alacritty = {
    enable = mkEnableOption "Alacritty";
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
      window = {
        decorations = "none";
        startup_mode = "maximized";
        dynamic_title = true;
        opacity = 0.6;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
      live_config_reload = true;
      font = {
        normal.family = "JetBrains Mono";
        bold.family = "JetBrains Mono";
        italic.family = "JetBrains Mono";
        bold_italic.family = "JetBrains Mono";
        size = 11;
      };
      };

    };
  };
}
