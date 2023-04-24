resource "tfe_workspace" "default" {
  name         = var.name
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "${var.name}/${var.name}"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = "terraform/${var.name}"
  description       = "Shikanime"
  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace" "totalenergies" {
  name         = "totalenergies"
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "${var.name}/${var.name}"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = "terraform/totalenergies"
  description       = "TotalEnergies"
  lifecycle {
    prevent_destroy = true
  }
}
