{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.elixir
    pkgs.erlang
    pkgs.rebar3
  ];

  # Local programs
  home.sessionPath = [
    "${config.xdg.dataHome}/mix/escripts"
  ];

  # Make Mix toolchain to be the XDG compliant by default
  home.sessionVariables.MIX_XDG = 1;

  programs.zsh.oh-my-zsh.plugins = [
    "mix"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      elixir
      erlang
      heex
      eex
    ]))
  ];
}
