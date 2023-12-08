{ pkgs, ... }:

let
  python = pkgs.python3Full.withPackages (ps: [
    ps.virtualenv
    ps.poetry
    ps.pdm
    ps.pipx
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
  ];
}
