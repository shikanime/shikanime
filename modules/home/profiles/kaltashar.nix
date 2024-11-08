{ lib, pkgs, ... }:

{
  nix.package = pkgs.nix;

  programs.zsh.initExtra = ''
    # Fix GPG TTY
    export GPG_TTY=$(tty)

    if command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi

    if [ -d "/opt/homebrew/opt/openjdk/bin" ]; then
      export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    fi
  '';
}
