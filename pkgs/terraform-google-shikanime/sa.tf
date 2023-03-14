resource "google_service_account" "github_action" {
  project      = var.google.project
  account_id   = "${var.name}-github-action"
  display_name = "Github Actions default service account"
}
