resource "tfe_workspace" "default" {
  name         = var.name
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "shikanime/shikanime"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = "terraform/shikanime"
  description       = "Shikanime"
  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace" "platform" {
  name         = "platform"
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "shikanime/shikanime"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = "terraform/platform"
  description       = "Platform"
  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace" "totalenergies" {
  name         = "totalenergies"
  organization = tfe_organization.default.name
  auto_apply   = true
  vcs_repo {
    identifier                 = "shikanime/shikanime"
    github_app_installation_id = var.github.app_installation_id
  }
  working_directory = "terraform/totalenergies"
  description       = "TotalEnergies"
  lifecycle {
    prevent_destroy = true
  }
}

resource "null_resource" "cachix" {
  triggers = var.cachix
}

resource "tfe_variable" "cachix" {
  key          = "cachix"
  value        = jsonencode(var.cachix)
  sensitive    = true
  hcl          = true
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
  description  = "Cachix token"
  lifecycle {
    replace_triggered_by = [null_resource.cachix]
  }
}

resource "null_resource" "wakabox" {
  triggers = var.wakabox
}

resource "tfe_variable" "wakabox" {
  key          = "wakabox"
  value        = jsonencode(var.wakabox)
  sensitive    = true
  hcl          = true
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
  description  = "Wakabox config"
  lifecycle {
    replace_triggered_by = [null_resource.wakabox]
  }
}

resource "null_resource" "wakatime" {
  triggers = var.wakatime
}

resource "tfe_variable" "wakatime" {
  key          = "wakatime"
  value        = jsonencode(var.wakatime)
  sensitive    = true
  hcl          = true
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
  description  = "Wakatime config"
  lifecycle {
    replace_triggered_by = [null_resource.wakatime]
  }
}

resource "null_resource" "github" {
  triggers = var.github
}

resource "tfe_variable" "github" {
  key          = "GITHUB_TOKEN"
  value        = var.github.token
  sensitive    = true
  category     = "env"
  workspace_id = tfe_workspace.default.id
  description  = "Github token"
  lifecycle {
    replace_triggered_by = [null_resource.github]
  }
}


resource "tfe_variable" "totalenergies_github" {
  key          = "GITHUB_TOKEN"
  value        = var.github.token
  sensitive    = true
  category     = "env"
  workspace_id = tfe_workspace.totalenergies.id
  description  = "Github token"
  lifecycle {
    replace_triggered_by = [null_resource.github]
  }
}
