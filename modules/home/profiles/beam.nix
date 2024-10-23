{ config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.xdg.configHome}/mix/escripts"
  ];

  # Make Mix toolchain to be the XDG compliant by default
  home.sessionVariables.MIX_XDG = 1;

  programs.zsh.oh-my-zsh.plugins = [
    "mix"
  ];
}
