resource "tfe_workspace" "default" {
  for_each = {
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
  name         = each.value.name
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "shikanime/shikanime"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = each.value.working_directory
  description       = each.value.description
  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace_variable_set" "google_provider" {
  for_each = {
    shikanime = {}
    studio    = {}
  }
  workspace_id    = tfe_workspace.default[each.key].id
  variable_set_id = tfe_variable_set.google_provider.id
}
