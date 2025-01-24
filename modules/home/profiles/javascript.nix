{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm";
  };

  home.packages = [
    pkgs.typescript-language-server
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "deno"
    "bun"
    "npm"
    "yarn"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/node.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/npm.nu
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/npm/npm-completions.nu
  '';
}
