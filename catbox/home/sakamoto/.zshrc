# Immutable Oh My ZSH installation
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="true"

# Ignore dotenv prompt
export ZSH_DOTENV_PROMPT="false"

# Append local bin path
export PATH="${HOME}/.local/bin:${PATH}"

# Append Krew path
export PATH="${HOME}/.krew/bin:${PATH}"

# Define Oh My ZSH plugins
plugins=(dotenv asdf git debian)

# Oh My Zsh
test -r ${HOME}/.oh-my-zsh/oh-my-zsh.sh &&
  . ${HOME}/.oh-my-zsh/oh-my-zsh.sh >/dev/null 2>/dev/null

# Starship shell
eval $(starship init zsh)
