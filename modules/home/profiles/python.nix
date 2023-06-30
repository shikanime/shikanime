{
  programs.neovim.withPython3 = true;

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
