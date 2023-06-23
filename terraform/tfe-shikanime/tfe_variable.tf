resource "tfe_variable_set" "tfc" {
  for_each     = tfe_workspace.default
  name         = "TFC (${each.value.name})"
  description  = "TFC variables for ${each.value.name}"
  organization = tfe_organization.default.name
}

resource "tfe_variable" "tfc_organization_id" {
  for_each        = tfe_workspace.default
  key             = "tfc_organization_id"
  value           = data.tfe_organization.default.external_id
  category        = "terraform"
  description     = "Organization id"
  variable_set_id = tfe_variable_set.tfc[each.key].id
}

resource "tfe_variable" "tfc_workspace_id" {
  for_each        = tfe_workspace.default
  key             = "tfc_workspace_id"
  value           = each.value.id
  category        = "terraform"
  description     = "Workspace id"
  variable_set_id = tfe_variable_set.tfc[each.key].id
}

resource "tfe_variable_set" "google_provider" {
  for_each = {
    google-shikanime-studio      = {}
    google-shikanime-studio-labs = {}
  }
  name         = "Google Provider (${each.key})"
  description  = "Google Provider variables for ${each.key}"
  organization = tfe_organization.default.name
}

resource "tfe_variable" "tfc_google_provider_auth" {
  for_each        = tfe_variable_set.google_provider
  key             = "TFC_GCP_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "Enable GCP provider auth"
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}

resource "tfe_variable" "tfc_google_project_number" {
  for_each        = tfe_variable_set.google_provider
  key             = "TFC_GCP_PROJECT_NUMBER"
  value           = lookup(data.tfe_outputs.default[each.key].values, "project_number", null)
  category        = "env"
  description     = "Project number"
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}

resource "tfe_variable" "tfc_google_workload_pool_id" {
  for_each        = tfe_variable_set.google_provider
  key             = "TFC_GCP_WORKLOAD_POOL_ID"
  value           = lookup(data.tfe_outputs.default[each.key].values, "workload_identity_pool_id", null)
  category        = "env"
  description     = "Workload pool id"
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}

resource "tfe_variable" "tfc_workload_provider_id" {
  for_each        = tfe_variable_set.google_provider
  key             = "TFC_GCP_WORKLOAD_PROVIDER_ID"
  value           = lookup(data.tfe_outputs.default[each.key].values, "workload_identity_pool_provider_id", null)
  category        = "env"
  description     = "Workload provider id"
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}

resource "tfe_variable" "tfc_run_service_account_email" {
  for_each        = tfe_variable_set.google_provider
  key             = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value           = lookup(data.tfe_outputs.default[each.key].values, "run_service_account_email", null)
  category        = "env"
  description     = "Run service account email"
  variable_set_id = tfe_variable_set.google_provider[each.key].id
}
