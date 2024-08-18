{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs-unstable";
    git-hosts = {
      url = "https://gitlab.com/ineo6/hosts/-/raw/master/hosts";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixpkgs-unstable, git-hosts, ... }:
  let 
    system = "x86_64-linux"; 
    pkgs-unstable = import nixpkgs-unstable {
	    inherit system;
            config.allowBroken = true;
            config.allowUnfree = true;
            config.nvidia.acceptLicense = true;
	    overlays = [ inputs.nixpkgs-wayland.overlay ];
	  };
  in {
    nixosConfigurations = {
      luckynix = nixpkgs.lib.nixosSystem rec {
        inherit system;
	specialArgs = { inherit pkgs-unstable git-hosts; };
        modules = [
          ./configuration.nix
	  {config.nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];}
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dingduck = import ./home/home.nix;
	    home-manager.extraSpecialArgs = inputs // {inherit system pkgs-unstable;};

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
