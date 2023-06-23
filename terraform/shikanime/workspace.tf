resource "tfe_workspace" "default" {
  for_each = {
    shikanime = {
      name              = "tfe-shikanime"
      display_name      = "Terrafom Cloud Shikanime"
      description       = "Terrafom Cloud Shikanime"
      working_directory = "terraform/tfe-shikanime"
    }
    github = {
      name              = "github-shikanime"
      display_name      = "GitHub Shikanime"
      description       = "GitHub Shikanime"
      working_directory = "terraform/github-shikanime"
    }
    studio = {
      name              = "google-shikanime-studio"
      display_name      = "Google Shikanime Studio"
      description       = "Google Shikanime Studio"
      working_directory = "terraform/google-shikanime-studio"
    }
    studio-labs = {
      name              = "google-shikanime-studio-labs"
      display_name      = "Google Shikanime Studio Labs"
      description       = "Google Shikanime Studio Labs"
      working_directory = "terraform/google-shikanime-studio-labs"
    }
    totalenergies = {
      name              = "github-totalenergies"
      display_name      = "GitHub TotalEnergies"
      description       = "GitHub TotalEnergies"
      working_directory = "terraform/github-totalenergies"
    }
  }
  name         = each.value.name
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "shikanime/shikanime"
    github_app_installation_id = "ghain-jGUbBPSwRf4ceNGo"
  }
  working_directory = each.value.working_directory
  description       = each.value.description
  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace_variable_set" "tfc" {
  for_each = {
    studio      = {}
    studio-labs = {}
  }
  workspace_id    = tfe_workspace.default[each.key].id
  variable_set_id = tfe_variable_set.tfc[each.key].id
}

resource "tfe_workspace_variable_set" "google_provider" {
  for_each = {
    studio      = {}
    studio-labs = {}
  }
  workspace_id    = tfe_workspace.default[each.key].id
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}
