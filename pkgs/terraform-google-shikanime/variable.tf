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

variable "gitlab" {
  type = object({
    owner = string
  })
  description = "GitLab configuration"
  default = {
    owner = "shikalegend"
  }
}

variable "github" {
  type = object({
    owner = string
    reviewers = map(object({
      username = string
    }))
  })
  description = "GitHub configuration"
  default = {
    owner = "shikanime"
    reviewers = {
      shikanime = {
        username = "shikanime"
      }
    }
  }
}

variable "ssh_keys" {
  type = map(object({
    name               = string
    public_key_openssh = string
  }))
  description = "SSH keys"
  default = {
    shikanime = {
      name               = "shikanime"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpVHzBrvtlzh0eLr6qNttBd5NBZawNJ7PtcAuHJ6pc7 william.phetsinorath@shikanime.studio"
    }
    sfeir = {
      name               = "sfeir"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2+ZmUgNPNepyMTJnjcu6LoGxEJh5ny8Oxe7bLuFx9q phetsinorath.w@sfeir.com"
    }
    paprec = {
      name               = "paprec"
      public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsdYurmBmZpWrDV5EJWZlcCPCU3yTyv1uoe7TzQsYAy phetsinorath.w@sfeir.com"
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
