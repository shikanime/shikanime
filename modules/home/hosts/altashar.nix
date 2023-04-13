{ pkgs, lib, ... }:

with lib;

{
  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkAfter ''
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    fi
    if ! command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi
  '';
}
