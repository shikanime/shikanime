terraform {
  required_version = "~> 1.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.44"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.23"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  backend "remote" {
    organization = "shikanime"
    workspaces {
      name = "platform"
    }
  }
}
