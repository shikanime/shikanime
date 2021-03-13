# Zsh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Local
export PATH="${HOME}/.local/bin:${PATH}"

# Oh My Zsh
export ZSH="${HOME}/.oh-my-zsh"
plugins=(
  git
  debian
)
test -r ${ZSH}/oh-my-zsh.sh &&
  . ${ZSH}/oh-my-zsh.sh >/dev/null 2>/dev/null

# Starship shell
eval $(starship init zsh)
