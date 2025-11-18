{
  lib,
  pkgs,
  ...
}:

{
  programs = {
    go.enable = true;

    helix.languages.language-server = {
      gopls.command = "${lib.getExe pkgs.gopls}";
    };

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
    '';
  };
}
