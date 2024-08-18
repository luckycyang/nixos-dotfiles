{config, ...}:
{
  imports = [
    ./vscode.nix
    ./virt-manager.nix
  ];
  # default program
  config = {
    programs = {
      gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = true;
        gamescopeSession.args = [ "--filter" "nis" ];
      };
      nm-applet.enable = true;
    };
  };
  config = { 
    hardware.steam-hardware.enable = true; 
  };
  # user programs
  config = {
    modules.programs = {
      vscode.enable = true;
      virt-manager.enable = true;
    };
  };
}
