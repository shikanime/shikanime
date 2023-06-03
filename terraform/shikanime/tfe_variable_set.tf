resource "tfe_variable_set" "google_provider" {
  name         = "Google Provider"
  description  = "Google project variables"
  organization = tfe_organization.default.name
}

resource "tfe_variable" "tfc_google_provider_auth" {
  key             = "TFC_GCP_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "Enable GCP provider auth"
  variable_set_id = tfe_variable_set.google_provider.id
}

resource "tfe_variable" "tfc_google_project_number" {
  key             = "TFC_GCP_PROJECT_NUMBER"
  value           = module.google_project.number
  category        = "env"
  description     = "Project number"
  variable_set_id = tfe_variable_set.google_provider.id
}

resource "tfe_variable" "tfc_google_workload_pool_id" {
  key             = "TFC_GCP_WORKLOAD_POOL_ID"
  value           = google_iam_workload_identity_pool.tfc_pool.workload_identity_pool_id
  category        = "env"
  description     = "Workload pool id"
  variable_set_id = tfe_variable_set.google_provider.id
}

resource "tfe_variable" "tfc_workload_provider_id" {
  key             = "TFC_GCP_WORKLOAD_PROVIDER_ID"
  value           = google_iam_workload_identity_pool_provider.tfc_pool_provider.workload_identity_pool_provider_id
  category        = "env"
  description     = "Workload provider id"
  variable_set_id = tfe_variable_set.google_provider.id
}

resource "tfe_variable" "tfc_run_service_account_email" {
  key             = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value           = module.tfc_google_sa.email
  category        = "env"
  description     = "Run service account email"
  variable_set_id = tfe_variable_set.google_provider.id
}
