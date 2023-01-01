{ pkgs, lib, ... }:

with lib;

{
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
    fi
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
