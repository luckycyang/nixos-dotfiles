{config, ...}:
{
  imports = [
    ./wm
    ./fonts.nix
    ./themes.nix
  ];

  config.modules = {
    graphical.wm = {
      hyprland.enable = true;
      pyprland.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      # eww.enable = true;
    };
    themes.nordic.enable = true;
    
  };
}
