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
    wakabox = string
    nix     = string
  })
  description = "Scaleway secrets ID"
  default = {
    wakabox = "677816c8-59be-4daf-acaf-1ef71c8d2f9a"
    nix     = "5363081a-f553-45b5-8260-8b74a0a04d93"
  }
}