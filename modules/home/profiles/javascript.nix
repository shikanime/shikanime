{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "deno"
    "bun"
    "npm"
    "yarn"
  ];

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/node.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/auto-generate/completions/npm.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/npm/npm-completions.nu
    use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/yarn/yarn-v4-completions.nu
  '';
}
