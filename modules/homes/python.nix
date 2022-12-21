{ pkgs, ... }:

let
  python3 = pkgs.python3.withPackages (pypkgs: with pypkgs; [
    pip
  ]);
in
{
  home.packages = [
    python3
    pkgs.poetry
    pkgs.python3Packages.pipx
    pkgs.python3Packages.black
  ];

  programs.neovim.withPython3 = true;

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
