output "github_pool_id" {
  value = google_iam_workload_identity_pool.github_pool.id
}

output "github_pool_short_id" {
  value = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  description = "Short ID of the Workload Identity Pool"
}