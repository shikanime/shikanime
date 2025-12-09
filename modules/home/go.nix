{ pkgs, ... }:

{
  home.packages = [
    pkgs.gopls
  ];

  programs = {
    go.enable = true;

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
    '';
  };
}
