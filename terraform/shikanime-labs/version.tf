terraform {
  required_version = "~> 1.0"
  backend "remote" {
    organization = "shikanime"
    workspaces {
      name = "labs"
    }
  }
}
