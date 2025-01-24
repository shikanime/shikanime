{ pkgs, ... }:

{
  programs.helix.languages.language-server = {
    bash-language-server.command = "${pkgs.bash-language-server}/bin/bash-language-server";
    clangd.command = "${pkgs.clang-tools}/bin/clangd";
  };
}
