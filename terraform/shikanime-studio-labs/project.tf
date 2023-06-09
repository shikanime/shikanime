module "google_project" {
  source          = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project"
  name            = "shikanime-studio-labs"
  project_create  = true
  billing_account = "018C2E-353598-F0F3A5"
  services = [
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "aiplatform.googleapis.com",
    "storage-component.googleapis.com",
    "notebooks.googleapis.com",
    "dataflow.googleapis.com",
    "artifactregistry.googleapis.com",
    "drive.googleapis.com"
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
