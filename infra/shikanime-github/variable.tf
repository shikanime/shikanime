variable "apps" {
  type = object({
    github_actions = number
    operator       = number
  })
  description = "Application names"
  default = {
    github_actions = 15368
    operator       = 1095999
  }
}

variable "repositories" {
  type = object({
    algorithm      = string
    features       = string
    identities     = string
    manifests      = string
    shikanime      = string
    websites       = string
  })
  description = "GitHub repositories"
  default = {
    algorithm      = "algorithm"
    features       = "features"
    identities     = "identities"
    manifests      = "manifests"
    shikanime      = "shikanime"
    websites       = "websites"
  }
}

variable "nix" {
  type = object({
    cachix_auth_token = string
    gpg_passphrase    = string
    gpg_private_key   = string
    github_token      = string
  })
  description = "Nix configuration secrets"
  sensitive   = true
}

variable "wakabox" {
  type = object({
    github_token     = string
    wakatime_api_key = string
  })
  description = "Wakabox configuration secrets"
  sensitive   = true
}

variable "operator" {
  type = object({
    ssh_private_key = string
  })
  description = "Operator configuration secrets"
  sensitive   = true
}
