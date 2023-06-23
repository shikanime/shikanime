terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.67"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  backend "remote" {
    organization = "shikanime"
    workspaces {
      name = "google-shikanime-studio-labs"
    }
  }
}
