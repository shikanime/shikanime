{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
  '';
}
