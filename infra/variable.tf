variable "apps" {
  type = object({
    github_actions = number
    operator       = number
  })
  description = "Application names"
  default = {
    operator       = 1095999
    github_actions = 15368
  }
}

variable "repositories" {
  type = object({
    shikanime  = string
    features   = string
    identities = string
  })
  description = "GitHub repositories"
  default = {
    shikanime  = "shikanime"
    features   = "features"
    identities = "identities"
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
    wakabox  = "677816c8-59be-4daf-acaf-1ef71c8d2f9a"
    nix      = "5363081a-f553-45b5-8260-8b74a0a04d93"
    operator = "993e60fe-8192-4207-bf1c-110115d4ae46"
  }
}