terraform {
  required_version = "~> 1.8"
  backend "s3" {
    bucket                      = "shikanime-opentofu-state"
    key                         = "terraform.tfstate"
    region                      = "WEUR"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_s3_checksum            = true
    endpoints = {
      s3 = "https://d4e789904d6943d8cd524e19c5cb36bd.r2.cloudflarestorage.com"
    }
  }
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.4"
    }
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.43"
    }
  }
}
