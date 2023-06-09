data "tfe_outputs" "default" {
  for_each = {
    shikanime = {
      workspace_name = "shikanime"
    }
    studio = {
      workspace_name = "shikanime-studio"
    }
    totalenergies = {
      workspace_name = "shikanime-totalenergies"
    }
  }
  organization = tfe_organization.default.name
  workspace    = each.value.workspace_name
}
