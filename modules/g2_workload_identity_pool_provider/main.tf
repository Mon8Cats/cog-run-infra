resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider = google-beta
  project  = var.project_id 
  workload_identity_pool_id         = var.wi_pool_id
  workload_identity_pool_provider_id = var.wi_pool_provider_id
  display_name                      = "WI Pool Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Specify the condition to match GitHub's repository claim
  attribute_condition = "attribute.repository == '${var.github_repository}'"

}