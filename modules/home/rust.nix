{ pkgs, config, ... }:

{
  # Make Rustup be XDG compliant
  home.sessionVariables.RUSTUP_HOME = "${config.xdg.dataHome}/rustup";

  # Make Cargo XDG compliant
  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/rustup";

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      rust
    ]))
  ];
}
