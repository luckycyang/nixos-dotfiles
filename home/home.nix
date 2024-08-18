{ config, pkgs, nixpkgs-unstable, ... }:
let
  pkgs-unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in 
{
  imports = [
    ./graphical
    ./terminal
    ./programs
    ./services
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dingduck";
  home.homeDirectory = "/home/dingduck";

  home.packages = (with pkgs; [
    ]) ++ (with pkgs-unstable; [
      # browser
      google-chrome

      # telegram
      telegram-desktop

      termius
      qq




      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      eza # A modern replacement for ‘ls’
      networkmanagerapplet
      pavucontrol
    ]);
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
