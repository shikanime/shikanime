{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    telemetry.mode = "off";
  };

  programs.helix.languages.language-server = {
    gopls.command = "${lib.getExe gopls}";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
  '';
}
