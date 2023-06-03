resource "tfe_workspace" "default" {
  for_each     = local.tfc_workspaces
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
  for_each        = local.google_projects
  workspace_id    = tfe_workspace.default[each.key].id
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}
