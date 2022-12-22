{ pkgs, config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.xdg.dataHome}/go/bin"
  ];

  programs.go = {
    enable = true;
    goPath = ".local/share/go";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      go
      gomod
    ]))
  ];
}
