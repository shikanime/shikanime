module "service_accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~> 3.0"

  project_id   = module.project.project_id
  names        = ["infra-operator"]
  display_name = "Infrastructure Operator Service Account"

  project_roles = [
    "${module.project.project_id}=>roles/browser",
    "${module.project.project_id}=>roles/iam.securityAdmin",
    "${module.project.project_id}=>roles/iam.workloadIdentityPoolAdmin",
    "${module.project.project_id}=>roles/serviceusage.serviceUsageAdmin",
    "${module.project.project_id}=>roles/iam.serviceAccountAdmin",
  ]
}