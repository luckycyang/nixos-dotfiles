{ config, lib, pkgs, nixpkgs-unstable, ...}:
with lib;
let
cfg = config.modules.graphical.wm.waybar;
pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";};
in
{
  options.modules.graphical.wm.waybar = { enable = mkEnableOption "Waybar"; };
  config = mkIf cfg.enable {
    xdg.configFile."waybar/style.css".source = ./style.css;
    xdg.configFile."waybar/config".source = ./config;
    programs.waybar = {
    enable = true;
    package = pkgs-unstable.waybar;
    };
  };
}
