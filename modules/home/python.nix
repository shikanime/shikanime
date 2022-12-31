{ pkgs, lib, config, ... }:

with lib;

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

  programs.zsh.initExtra = ''
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    elif [ -d ${config.xdg.dataHome}/anaconda3 ]; then
      source ${config.xdg.dataHome}/anaconda3/bin/activate
    fi
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
