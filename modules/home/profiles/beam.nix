{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "mix"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/elixir.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/mix/mix-completions.nu
  '';
}
