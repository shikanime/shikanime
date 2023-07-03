module "google_project" {
  source          = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project"
  name            = "shikanime-studio"
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
    "drive.googleapis.com",
    "run.googleapis.com",
    "firebasehosting.googleapis.com",
    "runapps.googleapis.com",
    "firestore.googleapis.com"
  ]
}

resource "null_resource" "google_project" {
  triggers = {
    id = module.google_project.id
  }
  lifecycle {
    prevent_destroy = true
  }
}