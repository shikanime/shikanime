terraform {
  required_version = "~> 1.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.44"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  backend "remote" {
    organization = "shikanime"
    workspaces {
      name = "shikanime"
    }
  }
}
