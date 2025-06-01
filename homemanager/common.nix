{ pkgs, lib, config, myUsername, hosts, inputs, ... }:

{
  imports = [
    ./common-parts/applications.nix
    ./common-parts/development.nix
    ./common-parts/shell.nix
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = myUsername;
  home.homeDirectory = "/home/${myUsername}";
}
