variable "region" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "connection_parent" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}


variable "repo_name_gcp" {
  description = "The repository name in GCP"
  type        = string
}

variable "repo_uri_remote" {
  description = "Custom service account email for Cloud Build"
  type        = string
}
