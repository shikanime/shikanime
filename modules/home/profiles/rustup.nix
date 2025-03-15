{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.rustup
  ];

  home.sessionPath = [
    "${config.xdg.configHome}/cargo/bin"
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.configHome}/cargo";
    RUSTUP_HOME = "${config.xdg.configHome}/rustup";
  };

  programs.helix.languages.language-server = {
    rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu
  '';
}
