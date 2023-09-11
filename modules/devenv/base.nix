{ pkgs, ... }:

{
  pre-commit.hooks = {
    markdownlint.enable = true;
    shfmt.enable = true;
    nixpkgs-fmt.enable = true;
    statix.enable = true;
    deadnix.enable = true;
    prettier.enable = true;
  };
  packages = [
    pkgs.nixpkgs-fmt
    pkgs.qemu
    pkgs.nodejs
  ];
}
