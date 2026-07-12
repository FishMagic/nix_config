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

  # 显式配置 D-Bus 会话地址，解决 WSL 环境下应用因找不到 $DISPLAY 尝试自动启动 dbus-daemon 失败的问题
  home.sessionVariables = {
    DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
