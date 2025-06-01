{ config, pkgs,lib, myUsername, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # 6.12 is the latest LTS kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Allow unfree (notably, for steam and nvidia)
  nixpkgs.config.allowUnfree = true;

  # locales according to my preferences
  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_TIME = "en_GB.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
  };

  # Enable CUPS for printing
  services.printing.enable = true;

  # Using network manager
  networking.networkmanager.enable = true;

  # Using pipewire instead of pulseaudio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable # If you need JACK applications

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true
  };

  users.groups.nixconf = {};
  # Create the user
  users.users.${myUsername} = {
    isNormalUser = true;
    description = "Pedro Godinho";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "docker" "nixconf"];
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    htop
    killall
    neofetch
  ];

  # Enable Docker
  virtualisation.docker.enable = true;

  # Steam (needs to be installed at system level, rather than home-manager level)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}
