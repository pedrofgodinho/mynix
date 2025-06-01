{ pkgs, lib, config, myUsername, hosts, inputs, ... }:

{
  home.packages = with pkgs; [
    firefox
    btop
    tree
    discord
    kdePackages.kate
  ];

  xdg.mimeApps = {
    enable = true;
  };
}
