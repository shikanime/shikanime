{ pkgs, ... }:

{
  pre-commit.hooks = {
    latexindent.enable = true;
    chktex.enable = true;
  };
  packages = [
    pkgs.texlive.combined.scheme-full
  ];
}
