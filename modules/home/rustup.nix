{ pkgs, ... }:

{
  home.packages = [
    pkgs.rust-analyzer
  ];

  programs = {
    rustup.enable = true;

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu
    '';
  };
}
