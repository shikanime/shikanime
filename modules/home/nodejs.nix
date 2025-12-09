{ pkgs, ... }:

{
  home.packages = [
    pkgs.typescript-language-server
    pkgs.vscode-langservers-extracted
  ];

  programs = {
    nodejs.enable = true;

    nushell.extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/node.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/npm.nu
    '';
  };
}
