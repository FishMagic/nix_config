# NixOS configuration for 'xray-server'
# This server configuration excludes distrobox, home-manager, and direnv development environments.
# It enables cloudflare-warp and xray using config.json decrypted via agenix.

{ config, lib, pkgs, ... }:

{
  networking.hostName = "xray-server";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 设置 root 用户属性和密码
  users.users.root = {
    hashedPassword = "$6$PleK7rI/ZO0wh9X/$hlA22wOHsdRnXkPP9rOmk4eoMIZYiizhp2pmaVsAU9nC/L/QfqwzHaicdkFr36VEKGdr1h24xUhUrLRGc9xW21";
  };

  # Define laevatein user account.
  users.users.laevatein = {
    isNormalUser = true;
    description = "laevatein";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$nGWa4kjb7wUltSIu$nwx9YN9zElGCZkpOTiu8HQm8vhkjGUCyYOWBUhv.mFstQ5HCKuot3miJX39sdc5Aj6eQeJxgqLSHdy6u3Osxu.";
    # 允许刚刚生成的 WSL SSH client key 登录 server 端的该用户
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNMnG7xeBCaDNp1RRHfww0nrd44JwdLEUpAh0CjZwke laevatein@DESKTOP-AJRT68L"
    ];
  };

  # Enable SSH service for remote management.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # 明确禁止 root SSH 登录
      PasswordAuthentication = true;
    };
  };

  # Open firewall ports for SSH (22) and xray inbound ports (443 and 8888).
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 8888 ];
  };

  # Enable Cloudflare WARP client service
  services.cloudflare-warp.enable = true;

  # agenix 密钥配置
  # 解密后的文件默认保存在 /run/agenix/xray-config
  age.secrets.xray-config = {
    file = ./secrets/xray-config.json.age;
    owner = "xray";
    group = "xray";
    mode = "0400";
  };

  # Enable Xray service using the decrypted configuration file path
  services.xray = {
    enable = true;
    settingsFile = config.age.secrets.xray-config.path;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    cloudflare-warp # Command-line client (warp-cli)
    xray            # Xray core
    agenix          # agenix CLI for managing secrets on the system
  ];

  # The state version of NixOS installed on this machine.
  system.stateVersion = "24.11"; 
}
