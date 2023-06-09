output "project_number" {
  value       = module.google_project.number
  description = "Project id"
}

output "workload_identity_pool_id" {
  value       = google_iam_workload_identity_pool.tfc.workload_identity_pool_id
  description = "Workload pool id"
}

output "workload_identity_pool_provider_id" {
  value       = google_iam_workload_identity_pool_provider.tfc.workload_identity_pool_provider_id
  description = "Workload provider id"
}

output "run_service_account_email" {
  value       = module.tfc_google_sa.email
  description = "Run service account email"
}