{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.deno
    pkgs.nodejs
  ];

  home.sessionVariables.NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";

  programs.zsh.oh-my-zsh.plugins = [
    "deno"
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
