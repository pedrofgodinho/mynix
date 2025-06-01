{ config, pkgs, lib, host, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = host;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Machine specific packages (only for hardware-specific stuff)
  # environment.systemPackages = with pkgs; [
    # specific-tool-for-desktop
  # ];

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ]; # Not using x server currently
  hardware.nvidia.open = true;

  # Ensure stateVersion is consistent if not overriden (defaults from common.nix)
  system.stateVersion = lib.mkDefault config.system.stateVersion;
}
