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
    organization = string
    reviewers = map(object({
      username = string
    }))
  })
  default = {
    organization = "shikanime"
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
