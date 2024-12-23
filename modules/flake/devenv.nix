{
  perSystem = { pkgs, ... }: {
    treefmt = {
      projectRootFile = "flake.nix";
      enableDefaultExcludes = true;
      programs = {
        actionlint.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        shfmt.enable = true;
        nixpkgs-fmt.enable = true;
        prettier.enable = true;
      };
      settings.global.excludes = [
        ".devenv/*"
        ".direnv/*"
        ".sl/*"
        "*.png"
        "LICENSE"
      ];
    };
    devenv.shells.default = {
      pre-commit.hooks.flake-checker.enable = true;
      devenv.root = "/workspaces/Shikanime/shikanime"; # TODO: Wait for https://github.com/cachix/devenv/issues/1461
      containers = pkgs.lib.mkForce { };
      languages.nix.enable = true;
      cachix = {
        enable = true;
        push = "shikanime";
      };
      packages = [
        pkgs.gh
        pkgs.nixos-anywhere
      ];
    };
  };
}
