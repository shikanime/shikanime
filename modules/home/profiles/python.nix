{ pkgs, ... }:

{
  home.packages = [
    pkgs.python312Packages.jedi-language-server
    pkgs.ruff
    pkgs.uv
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/python.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pdm/pdm-completions.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/poetry/poetry-completions.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pytest/pytest-completions.nu
  '';
}
