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

variable "ssh" {
  type = map(object({
    name       = string
    public_key = string
  }))
}

variable "cachix" {
  type = object({
    token = string
  })
}

variable "wakatime" {
  type = object({
    api_key = string
  })
}

variable "wakabox" {
  type = object({
    github_gist_id = string
    github_token   = string
  })
}
