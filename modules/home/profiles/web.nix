{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/config";
    NVM_DIR = "${config.xdg.configHome}/nvm";
  };

  programs.zsh.initExtra = ''
    if which brew > /dev/null; then
      if [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]; then
        source "$(brew --prefix)/opt/nvm/nvm.sh"
      fi
      if [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]; then
        source "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
      fi
    fi
  '';

  programs.zsh.oh-my-zsh.plugins = [
    "deno"
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim = {
    withNodeJs = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        javascript
        typescript
        css
        scss
        vue
        html
        graphql
        prisma
      ]))
    ];
  };
}
