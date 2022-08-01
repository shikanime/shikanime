{ pkgs, config, ... }:

{
  # Make Opam toolchain to be XDG compliant
  home.sessionVariables.OPAMROOT = "${config.xdg.dataHome}/opam";

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
