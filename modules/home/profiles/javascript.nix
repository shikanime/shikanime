{ config, ... }:

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

  home.packages = [
    pkgs.fnm
  ];

  programs.zsh.initExtra = ''
    eval "$(${pkgs.fnm}/bin/fnm env)"
  '';
}
