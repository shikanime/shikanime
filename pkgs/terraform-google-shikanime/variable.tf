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
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
    }))
  })
  description = "GitLab configuration"
  default = {
    owner = "shikalegend"
    ssh_keys = {
      shikanime = {
        name               = "shikanime"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpVHzBrvtlzh0eLr6qNttBd5NBZawNJ7PtcAuHJ6pc7 william.phetsinorath@shikanime.studio"
      }
    }
  }
}

variable "github" {
  type = object({
    owner = string
    reviewers = map(object({
      username = string
    }))
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
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
    ssh_keys = {
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
}

variable "sfeir" {
  type = object({
    owner = string
    ssh_keys = map(object({
      name               = string
      public_key_openssh = string
    }))
  })
  description = "Sfeir Gitlab configuration"
  default = {
    owner = "phetsinorath.w"
    ssh_keys = {
      sfeir = {
        name               = "sfeir"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2+ZmUgNPNepyMTJnjcu6LoGxEJh5ny8Oxe7bLuFx9q phetsinorath.w@sfeir.com"
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
