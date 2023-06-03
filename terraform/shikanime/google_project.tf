module "google_project" {
  source          = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project"
  name            = "shikanime-studio"
  project_create  = true
  billing_account = var.billing_account
  services = [
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}

resource "null_resource" "google_project" {
  triggers = {
    project_id = module.google_project.project_id
  }
  lifecycle {
    prevent_destroy = true
  }
}
