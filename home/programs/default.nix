{...}:
{
  imports = [
    ./obs-studio.nix
    ./helix.nix
  ];
  config.modules.programs = {
    helix.enable = true;
    obs-studio.enable = true;
  };
}
