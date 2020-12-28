# Zsh
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Krew
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

# Go
export PATH="${HOME}/go/bin:${PATH}"

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# Local
export PATH="${HOME}/.local/bin:${PATH}"

# Oh My Zsh
export ZSH="${HOME}/.oh-my-zsh"
plugins=(
  golang
  cargo
  vscode
  docker
  ubuntu
  git
  python
  rustup
  stack
  dotenv
  mix
  ssh-agent
  kubectl
  gcloud
  minikube
  yarn
  terraform
  npm
  asdf
)
. ${ZSH}/oh-my-zsh.sh &>/dev/null

# OPAM
. ${HOME}/.opam/opam-init/init.zsh &>/dev/null

# Rust Cargo
. $HOME/.cargo/env &>/dev/null

# Starship shell
eval $(starship init zsh)
