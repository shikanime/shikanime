{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/godoc.nu
  '';
}
