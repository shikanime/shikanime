{ pkgs, ... }:

{
  programs.helix.languages.language-server = {
    jdt.command = "${pkgs.jdt-language-server}/bin/jdtls";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/sbt.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/mvn/mvn-completions.nu
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "gradle"
    "sbt"
    "scala"
  ];
}
