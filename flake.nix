{
  description = "Shikanime's home configuration";

  inputs = {
    devenv.url = "github:cachix/devenv";
    devlib.url = "github:shikanime-studio/devlib";
    git-hooks.url = "github:cachix/git-hooks.nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    identities.url = "github:shikanime/identities";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  nixConfig = {
    extra-substituters = [
      "https://cachix.cachix.org"
      "https://devenv.cachix.org"
      "https://shikanime.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
    ];
  };

  outputs =
    inputs@{
      devenv,
      devlib,
      flake-parts,
      git-hooks,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/flake/darwin.nix
        ./modules/flake/devenv.nix
        ./modules/flake/nixos.nix
        devenv.flakeModule
        devlib.flakeModule
        git-hooks.flakeModule
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
