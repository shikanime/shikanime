{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.deno
    pkgs.nodejs
  ];

  home.sessionVariables.NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";

  home.file.".npmrc".source = config.lib.file.mkOutOfStoreSymlink ".config/npm/config";
  home.file.".npm".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/npm";

  programs.zsh.oh-my-zsh.plugins = [
    "deno"
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
