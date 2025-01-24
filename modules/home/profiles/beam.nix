{ pkgs, ... }:

{
  home.sessionVariables.MIX_XDG = "1";

  programs.helix.languages = {
    language-server = {
      elixir-ls.command = "${pkgs.elixir-ls}/bin/elixir-ls";
      erlang-ls.command = "${pkgs.erlang-ls}/bin/erlang_ls";
    };
  };

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/elixir.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/mix/mix-completions.nu
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "mix"
  ];
}
