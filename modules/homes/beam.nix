{ pkgs, config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.xdg.dataHome}/mix/escripts"
  ];

  # Make Mix toolchain to be the XDG compliant by default
  home.sessionVariables.MIX_XDG = 1;

  home.packages = [
    pkgs.elixir
    pkgs.erlang
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "mix"
  ];
}
