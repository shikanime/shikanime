{ config, pkgs, ... }:

{
  home.sessionPath = [
    "${config.xdg.configHome}/cargo/bin"
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.configHome}/cargo";
    RUSTUP_HOME = "${config.xdg.configHome}/rustup";
  };

  home.packages = [
    pkgs.rustup
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu
  '';
}
