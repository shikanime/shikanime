{ pkgs, ... }:

{
  home.packages = [ pkgs.mono ];

  programs.zsh.oh-my-zsh.plugins = [
    "dotnet"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      c_sharp
    ]))
  ];
}
