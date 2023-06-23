resource "google_storage_bucket" "deep_lake" {
  project  = var.project_id
  name     = "${var.project_id}-hivemind-deep-lake-datasets"
  location = "EU"
}
