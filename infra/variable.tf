variable "apps" {
  type = object({
    operator       = number
    github_actions = number
  })
  description = "Application names"
  default = {
    github_actions = 15368
    operator       = 1095999
  }
}

variable "repositories" {
  type = object({
    shikanime      = string
    ghstack_action = string
      ghstack_poc     = string
    features       = string
    identities     = string
  })
  description = "GitHub repositories"
  default = {
    features       = "features"
    ghstack_action = "ghstack-action"
    ghstack_poc     = "ghstack-poc"
    identities     = "identities"
    shikanime      = "shikanime"
  }
}

variable "secrets" {
  type = object({
    wakabox  = string
    nix      = string
    operator = string
  })
  description = "Scaleway secrets ID"
  default = {
    wakabox  = "41ec1000-749b-429d-98e9-57d3c2e646a3"
    nix      = "f617ec38-db68-4055-92d6-5913bd4f4b42"
    operator = "993e60fe-8192-4207-bf1c-110115d4ae46"
  }
}