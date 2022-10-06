{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; }; {
        curriculumVitae = callPackage ./pkgs/curriculum-vitae/default.nix { };
      }
    );

    devShell = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; };
      callPackage ./shell.nix { }
    );

    nixosConfigurations = {
      elkia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/profiles/qcow-image.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/home.nix
          ./modules/profiles/elkia.nix
          ./modules/users/devas.nix
          ./modules/remote/ssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
        ];
      };
      elvengard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/virtualisation/hyperv.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/home.nix
          ./modules/profiles/elvengard.nix
          ./modules/users/devas.nix
          ./modules/remote/ssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    homeConfigurations = {
      "williamphetsinorath@altashar" = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "22.05";
        configuration = ./modules/homes/host.nix;
        extraModules = [
          ./modules/homes/altashar.nix
          ./modules/homes/base.nix
          ./modules/homes/development.nix
          ./modules/homes/mix.nix
          ./modules/homes/go.nix
          ./modules/homes/opam.nix
          ./modules/homes/rustup.nix
          ./modules/homes/python.nix
          ./modules/homes/javascript.nix
          ./modules/homes/php.nix
          ./modules/homes/coursier.nix
          ./modules/homes/google.nix
          ./modules/homes/azure.nix
          ./modules/homes/terraform.nix
          ./modules/homes/aws.nix
          ./modules/homes/shikanime.nix
          ./modules/homes/sfeir.nix
          ./modules/homes/java.nix
          ./modules/homes/dotnet.nix
        ];
      };
      "devas@ishtar" = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = ./modules/homes/host.nix;
        extraModules = [
          ./modules/homes/ishtar.nix
          ./modules/homes/base.nix
          ./modules/homes/development.nix
          ./modules/homes/mix.nix
          ./modules/homes/go.nix
          ./modules/homes/opam.nix
          ./modules/homes/rustup.nix
          ./modules/homes/python.nix
          ./modules/homes/javascript.nix
          ./modules/homes/php.nix
          ./modules/homes/coursier.nix
          ./modules/homes/google.nix
          ./modules/homes/azure.nix
          ./modules/homes/terraform.nix
          ./modules/homes/aws.nix
          ./modules/homes/shikanime.nix
          ./modules/homes/sfeir.nix
          ./modules/homes/java.nix
          ./modules/homes/dotnet.nix
        ];
      };
    };
  };
}
