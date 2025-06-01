{ pkgs, lib, config, myUsername, hosts, inputs, ... }:

{
  home.packages = with pkgs; [
    zed-editor
  ];

  programs.git = {
    enable = true;
    userName = "Pedro Fernandez Godinho";
    userEmail = "pedro.fernandez.godinho@gmail.com";
    extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
    };
  };
}
