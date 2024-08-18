{
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib; let
  pkgs = pkgs-unstable;
  cfg = config.modules.programs.obs-studio;
in {
  options.modules.programs.obs-studio = {
    enable = mkEnableOption "obs-studio";
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
  };
}
