
variable "project_id" {
  description = "Project ID for the GCP project"
  type        = string
}

variable "project_number" {
  description = "Project number for the GCP project"
  type        = string
}

variable "region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-east1"
}

variable "api_list" {
  type        = list(string)
  description = "A list of APIs"
}

variable "secret_id_github" {
  description = "The Github Token Secret Id"
  type        = string
}
variable "secret_data_github" {
  description = "The Github Token Secret value"
  type        = string
}

variable "secret_id_db_user" {
  description = "The db user Secret Id"
  type        = string
}

variable "secret_data_db_user" {
  description = "The db user Secret value"
  type        = string
}

variable "secret_id_db_password" {
  description = "The db user Secret Id"
  type        = string
}


variable "secret_data_db_password" {
  description = "The db password Secret value"
  type        = string
}

variable "connection_name_github" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}


variable "app_installation_id_github" {
  description = "Custom service account email for Cloud Build"
  type        = string
  
}