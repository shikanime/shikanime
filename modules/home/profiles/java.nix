{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "sbt"
    "scala"
    "gradle"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/sbt.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/mvn/mvn-completions.nu
  '';
}
