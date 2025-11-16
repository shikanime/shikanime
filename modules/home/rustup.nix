{ pkgs, ... }:

{
  programs = {
    rustup.enable = true;

    helix.languages.language-server = {
      rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    };

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu
    '';
  };
}
