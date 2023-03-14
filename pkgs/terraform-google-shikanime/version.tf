terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.57"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.57"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.18"
    }
  }
}
