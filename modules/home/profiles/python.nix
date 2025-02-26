{ pkgs, ... }:

{
  home.packages = [
    pkgs.uv
  ];

  programs.helix.languages.language-server = {
    jedi.command = "${pkgs.python312Packages.jedi-language-server}/bin/jedi-language-server";
    ruff.command = "${pkgs.ruff}/bin/ruff";
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/python.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pdm/pdm-completions.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/poetry/poetry-completions.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/pytest/pytest-completions.nu
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "poetry"
    "python"
  ];
}
