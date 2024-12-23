{
  description = "Shikanime's home configuration";

  inputs = {
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    identities.url = "git+https://github.com/shikanime/identities?ref=main";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  nixConfig = {
    extra-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    extra-substituters = [
      "https://shikanime.cachix.org"
      "https://devenv.cachix.org"
    ];
  };

  outputs =
    inputs@{
      devenv,
      flake-parts,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/flake/darwin.nix
        ./modules/flake/devenv.nix
        ./modules/flake/home.nix
        ./modules/flake/nixos.nix
        devenv.flakeModule
        treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    };
}
