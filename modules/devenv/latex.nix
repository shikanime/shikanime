{ pkgs, ... }:

{
  pre-commit.hooks.latexindent.enable = true;
  packages = [
    pkgs.texlive.combined.scheme-full
  ];
}
