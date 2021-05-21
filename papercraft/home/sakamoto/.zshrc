# Zinit
. ${HOME}/.zinit/bin/zinit.zsh

# ZSH common utils
zinit light zsh-users/zsh-autosuggestions

# Starship shell
zinit ice from"gh-r" as"program" atload'!eval $(starship init zsh)'
zinit light starship/starship

# Oh My ZSH Plugins
zinit snippet OMZP::git
zinit snippet OMZP::debian
