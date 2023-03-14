terraform {
  required_version = "~> 1.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 15.9"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
  backend "remote" {
    organization = "shikanime"
    workspaces {
      name = "shikanime-studio"
    }
  }
}

provider "github" {
  owner = var.github.owner
}
