variable "name" {
  type        = string
  description = "Project name"
  default     = "shikanime"
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
      altashar = {
        name               = "Altashar"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
      }
      altashar_sfeir = {
        name               = "Altashar Sfeir"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2+ZmUgNPNepyMTJnjcu6LoGxEJh5ny8Oxe7bLuFx9q"
      }
      altashar_paprec = {
        name               = "Altashar Paprec"
        public_key_openssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsdYurmBmZpWrDV5EJWZlcCPCU3yTyv1uoe7TzQsYAy"
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
