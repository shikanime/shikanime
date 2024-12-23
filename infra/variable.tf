variable "repositories" {
  type = object({
    features   = string
    identities = string
    manifests  = string
    shikanime  = string
  })
  description = "GitHub repositories"
  default = {
    features   = "features"
    identities = "identities"
    manifests  = "manifests"
    shikanime  = "shikanime"
  }
}

variable "secrets" {
  type = object({
    nix     = string
    wakabox = string
  })
  description = "Scaleway secrets ID"
  default = {
    nix     = "5363081a-f553-45b5-8260-8b74a0a04d93"
    wakabox = "677816c8-59be-4daf-acaf-1ef71c8d2f9a"
  }
}