{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    env.GOPATH = "${config.xdg.dataHome}/go";
    telemetry.mode = "off";
  };

  programs.helix.languages.language-server = {
    gopls.command = "${pkgs.gopls}/bin/gopls";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
  '';
}
