module "google_project" {
  for_each        = local.google_projects
  source          = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project"
  name            = each.value.name
  project_create  = true
  billing_account = var.billing_account
  services        = each.value.services
}
