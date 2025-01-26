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
    ghstack_action = string
    identities     = string
    manifests      = string
    shikanime      = string
    websites       = string
  })
  description = "GitHub repositories"
  default = {
    algorithm      = "algorithm"
    features       = "features"
    ghstack_action = "ghstack-action"
    identities     = "identities"
    manifests      = "manifests"
    shikanime      = "shikanime"
    websites       = "websites"
  }
}

variable "secrets" {
  type = object({
    nix      = string
    operator = string
    wakabox  = string
  })
  description = "Scaleway secrets ID"
  default = {
    nix      = "f617ec38-db68-4055-92d6-5913bd4f4b42"
    operator = "993e60fe-8192-4207-bf1c-110115d4ae46"
    wakabox  = "41ec1000-749b-429d-98e9-57d3c2e646a3"
  }
}