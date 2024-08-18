{...}:

{
  imports = [
    ./driver.nix
    ./services
    ./programs
  ];

  modules = {
    # Video Driver
    hosts.driver.enable = true;
  };
}
