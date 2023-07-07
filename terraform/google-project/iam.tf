resource "google_iam_workload_identity_pool" "tfc" {
  project                   = module.google_project.project_id
  workload_identity_pool_id = "tfc-pool"
  display_name              = "TFC"
  description               = "Identity pool for Terraform Cloud Dynamic Credentials integration"
}

resource "google_iam_workload_identity_pool_provider" "tfc" {
  project                            = module.google_project.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.tfc.workload_identity_pool_id
  workload_identity_pool_provider_id = "tfc-provider"
  display_name                       = "TFC"
  description                        = "OIDC identity pool provider for Terraform Cloud Dynamic Credentials integration"
  # Use condition to make sure only token generated for a specific TFC Org can be used across org workspaces
  attribute_condition = "attribute.terraform_organization_id == \"${var.tfc_organization_id}\""
  attribute_mapping = {
    "google.subject"                        = "assertion.sub"
    "attribute.aud"                         = "assertion.aud"
    "attribute.terraform_run_phase"         = "assertion.terraform_run_phase"
    "attribute.terraform_project_id"        = "assertion.terraform_project_id",
    "attribute.terraform_project_name"      = "assertion.terraform_project_name",
    "attribute.terraform_workspace_id"      = "assertion.terraform_workspace_id"
    "attribute.terraform_workspace_name"    = "assertion.terraform_workspace_name"
    "attribute.terraform_organization_id"   = "assertion.terraform_organization_id"
    "attribute.terraform_organization_name" = "assertion.terraform_organization_name"
    "attribute.terraform_run_id"            = "assertion.terraform_run_id"
    "attribute.terraform_full_workspace"    = "assertion.terraform_full_workspace"
  }
  oidc {
    issuer_uri = "https://app.terraform.io/"
  }
}

module "tfc_service_account_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "~> 7.6"

  service_accounts = module.tfc_service_account.emails_list
  project          = module.google_project.project_id
  bindings = {
    "roles/iam.workloadIdentityUser" = [
      "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tfc.name}/attribute.terraform_workspace_id/${var.tfc_workspace_id}"
    ]
  }
}
