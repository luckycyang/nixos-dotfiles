{...}:
{
  imports = [
    ./mako.nix
  ];

  config.modules.services = {
    mako.enable = true;
  };
}
