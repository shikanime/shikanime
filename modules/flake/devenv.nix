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
        prettier = {
          enable = true;
          includes = [
            "*.css"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mjs"
            "*.ts"
            "*.tsx"
            "*.yaml"
          ];
          settings.plugins = [
            "prettier-plugin-astro"
            "prettier-plugin-tailwindcss"
          ];
        };
      };
      settings.global.excludes = [
        "**/node_modules"
        "*.jpg"
        "*.png"
        "*.gif"
        "*.webp"
        "*.ico"
      ];
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
        pkgs.glab
      ];
    };
  };
}
