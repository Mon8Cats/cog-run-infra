variable "project_id" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}


variable "wi_pool_id" {
  description = "Id of the workload idenitity pool"
  type        = string
}


variable "wi_pool_provider_id" {
  description = "Id of the workload idenitity provider"
  type        = string
}

variable "github_repository" {
  description = "Name of the github_repository"
  type        = string
}

