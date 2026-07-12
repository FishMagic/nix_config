# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most common.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define user account.
  users.users.laevatein = {
    isNormalUser = true;
    description = "laevatein";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$nGWa4kjb7wUltSIu$nwx9YN9zElGCZkpOTiu8HQm8vhkjGUCyYOWBUhv.mFstQ5HCKuot3miJX39sdc5Aj6eQeJxgqLSHdy6u3Osxu.";
  };

  # Podman and Distrobox configuration
  # Podman provides rootless container virtualization, which distrobox uses.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    distrobox # Container manager requested
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  # Most users should NEVER change this value after the initial install.
  system.stateVersion = "24.11"; 
}
