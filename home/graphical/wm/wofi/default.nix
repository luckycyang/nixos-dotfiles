{ config, lib, nixpkgs-unstable, ...}:
with lib;
let 
cfg = config.modules.graphical.wm.wofi;
pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";};
in
{
  options.modules.graphical.wm.wofi = {
    enable = mkEnableOption "Wofi";
  };
  config = mkIf cfg.enable {
    programs.wofi = {
    enable = true;
    package = pkgs-unstable.wofi;
    settings = {
      location = "center";
      allow_images = true;
    };
  };
  xdg.configFile.".config/style.css".source = ./style.css;
  };
}
