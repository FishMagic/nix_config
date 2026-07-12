{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "laevatein";
  home.homeDirectory = "/home/laevatein";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "24.11"; 

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # Add any user packages here
  ];

  # direnv configuration with nix-direnv integration
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
