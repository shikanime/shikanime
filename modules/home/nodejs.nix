{ pkgs, ... }:

{
  programs.nodejs.enable = true;

  programs.helix.languages.language-server = {
    typescript-language-server.command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
    vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
    vscode-eslint-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
    vscode-html-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/node.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/npm.nu
  '';
}
