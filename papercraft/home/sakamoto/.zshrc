# Starship shell
zinit from"gh-r" as"program" atload'!eval $(starship init zsh)' for \
  load starship/starship

# ZSH common utils
zinit wait"!" lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

# Oh My ZSH Plugins
zinit wait"!" lucid for \
  OMZP::git \
  OMZP::debian
