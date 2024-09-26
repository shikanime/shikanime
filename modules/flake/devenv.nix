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
    };
    devenv.shells.default = {
      containers = pkgs.lib.mkForce { };
      languages.nix.enable = true;
      cachix = {
        enable = true;
        push = "shikanime";
      };
      packages = [
        pkgs.gh
      ];
    };
  };
}
