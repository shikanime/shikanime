{ pkgs, config, ... }:

{
  # Make Rustup be XDG compliant
  home.sessionVariables.RUSTUP_HOME = "${config.xdg.dataHome}/rustup";

  # Make Cargo XDG compliant
  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/rustup";

  # Core global utilitary packages
  home.packages = [ pkgs.rustup ];

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
