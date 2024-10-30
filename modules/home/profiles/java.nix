{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "sbt"
    "scala"
    "gradle"
  ];

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/gradlew/gradlew-completions.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/mvn/mvn-completions.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/sbt/sbt-completions.nu
  '';
}
