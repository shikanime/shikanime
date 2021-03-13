# Zsh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Krew
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

# Local
export PATH="${HOME}/.local/bin:${PATH}"

# Oh My Zsh
export ZSH="${HOME}/.oh-my-zsh"
plugins=(
  cargo
  git
  debian
  rustup
  stack
  dotenv
  ssh-agent
  asdf
)
test -r ${ZSH}/oh-my-zsh.sh &&
  . ${ZSH}/oh-my-zsh.sh >/dev/null 2>/dev/null

# Rust Cargo
test -r ${HOME}/.cargo/env &&
  . ${HOME}/.cargo/env &>/dev/null 2>/dev/null

# Starship shell
eval $(starship init zsh)
