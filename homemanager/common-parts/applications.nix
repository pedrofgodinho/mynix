{ pkgs, lib, config, myUsername, host, inputs, ... }:

{
  home.packages = with pkgs; [
    # Apps
    firefox
    discord
    kdePackages.kate

    # Utilities
    btop
    killall
    neofetch
    tree
  ];

  xdg.mimeApps = {
    enable = true;
  };
}
