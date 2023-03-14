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
