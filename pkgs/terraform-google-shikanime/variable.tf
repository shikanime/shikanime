variable "name" {
  type        = string
  description = "Release name"
  default     = "shikanime"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "studio"
}

variable "github" {
  type = object({
    owner = string
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
    }))
  })
  description = "GitHub configuration"
  default = {
    owner = "shikanime"
    ssh_keys = {
      shikanime = {
        name               = "Shikanime"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
      }
      sfeir = {
        name               = "Sfeir"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2+ZmUgNPNepyMTJnjcu6LoGxEJh5ny8Oxe7bLuFx9q"
      }
      paprec = {
        name               = "Paprec"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsdYurmBmZpWrDV5EJWZlcCPCU3yTyv1uoe7TzQsYAy"
      }
      totalenergies = {
        name               = "TotalEnergies"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEcC9iJokc4BW6fTW9vz/X/0NhCHQf7WigeMz7ft2bi"
      }
    }
  }
}

variable "cachix" {
  type = object({
    token = string
  })
  sensitive = true
}

variable "wakatime" {
  type = object({
    api_key = string
  })
  sensitive = true
}

variable "wakabox" {
  type = object({
    github_gist_id = string
    github_token   = string
  })
  sensitive = true
}
