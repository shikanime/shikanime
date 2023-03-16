{
  # Eval Gthub Copilot
  programs.zsh.initExtra = ''
    if which github-copilot-cli > /dev/null; then
      eval "$(github-copilot-cli alias -- "$0 ")"
    fi
  '';
}
