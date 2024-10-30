{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/python.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pdm/pdm-completions.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/poetry/poetry-completions.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pytest/pytest-completions.nu
  '';
}
