{
  lib,
  pkgs,
  ...
}:

with lib;

{
  programs = {
    go = {
      enable = true;
      telemetry.mode = "off";
    };

    helix.languages.language-server = {
      gopls.command = "${getExe pkgs.gopls}";
    };

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
    '';
  };
}
