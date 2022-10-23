{ pkgs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (pypkgs: with pypkgs; [
    pip
    pipx
    black
    poetry
  ]);
in
{
  home.packages = [
    pythonEnv
  ];

  programs.neovim.withPython3 = true;

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
