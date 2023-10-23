{ pkgs, ... }:

let
  python = pkgs.python3Full.withPackages (ps: [
    ps.virtualenv
  ]);
in
{
  programs.neovim.withPython3 = true;

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];

  home.packages = [
    python
    pkgs.poetry
    pkgs.pdm
    pkgs.pipx
  ];
}
