terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.67"
    }
  }
  backend "remote" {
    organization = "shikanime"
    workspaces {
      prefix = "google-project-"
    }
  }
}
