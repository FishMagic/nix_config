{
  description = "NixOS configuration with Flakes and Home Manager (supporting WSL and xray-server)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "tarball+https://github.com/nix-community/NixOS-WSL/archive/refs/heads/release-26.05.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # 引入 agenix 密钥管理工具
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, agenix, ... }@inputs: {
    # 1. 常规物理机/虚拟机配置 (执行: sudo nixos-rebuild switch --flake .#nixos)
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.laevatein = import ./home.nix;
        }
      ];
    };

    # 2. WSL 环境配置 (执行: sudo nixos-rebuild switch --flake .#wsl)
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 导入 WSL 模块进行虚拟硬件和集成配置 (WSL 不需要常规的 hardware-configuration.nix)
        nixos-wsl.nixosModules.default
        {
          wsl.enable = true;
          wsl.defaultUser = "laevatein";
        }
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.laevatein = import ./home.nix;
        }
      ];
    };

    # 3. xray-server 配置 (执行: sudo nixos-rebuild switch --flake .#xray-server)
    nixosConfigurations.xray-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./xray-server.nix
        # 导入 agenix 模块以解密密钥
        agenix.nixosModules.default
      ];
    };
  };
}
