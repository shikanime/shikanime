{ pkgs, ... }:

{
  home.packages = [
    pkgs.poetry
    pkgs.sphinx
    pkgs.python3Packages.pipx
    pkgs.python3Packages.black
    (pkgs.python3.withPackages (pypkgs: with pypkgs; [ pip ]))
  ];

  programs.neovim = {
    withPython3 = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        python
      ]))
    ];
  };

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
