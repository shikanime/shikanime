locals {
  google_projects = {
    studio = {
      name         = "shikanime-studio"
      display_name = "Shikanime Studio"
      services     = []
    }
  }
  tfc_workspaces = {
    shikanime = {
      name              = "shikanime"
      display_name      = "Shikanime"
      description       = "Shikanime"
      working_directory = "terraform/shikanime"
    }
    studio = {
      name              = "shikanime-studio"
      display_name      = "Shikanime Studio"
      description       = "Shikanime Studio"
      working_directory = "terraform/shikanime-studio"
    }
    totalenergies = {
      name              = "shikanime-totalenergies"
      display_name      = "Shikanime TotalEnergies"
      description       = "Shikanime TotalEnergies"
      working_directory = "terraform/shikanime-totalenergies"
    }
  }
}
