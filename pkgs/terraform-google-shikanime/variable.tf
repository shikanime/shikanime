variable "name" {
  type        = string
  description = "Release name"
  default     = "shikanime-studio"
}

variable "github" {
  type = object({
    organization = string
    repository   = string
    reviewers = map(object({
      username = string
    }))
  })
  default = {
    organization = "shikanime"
    repository   = "shikanime"
    reviewers = {
      shikanime = {
        username = "shikanime"
      }
    }
  }
}

variable "google" {
  type = object({
    project = string
    region  = string
  })
  default = {
    project = "shikanime-studio"
    region  = "europe-west1"
  }
}

variable "rclone" {
  type = object({
    client_id     = string
    client_secret = string
  })
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
