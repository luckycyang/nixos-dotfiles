{config, ...}:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  config.modules.terminal = {
    alacritty.enable = true;
    starship.enable = true;
  };

}
