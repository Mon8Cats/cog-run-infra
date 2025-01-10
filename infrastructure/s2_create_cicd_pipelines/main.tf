locals {
  cloud_build_service_account_email = "service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}


module "service_apis" {
  source                  = "../../modules/a1_service_apis"
  project_id  = var.project_id
  api_services = var.api_list
}


module "service_apis" {
  source                  = "../../modules/a01_gcp_service_apis"
  project_id  = var.project_id
  api_services = var.api_list
}


module "secret_github_token" {
  source  = "../../modules/e1_secret_manager"
  project_id          = var.project_id
  secret_id         = var.secret_id_github
  secret_data = var.secret_data_github
}

module "github_token_secret_access_cloud_build_sa" {
  source  = "../../modules/e3_secret_iam_member"
  secret_id = var.secret_id_github
  service_account_email = local.cloud_build_service_account_email

  depends_on = [ module.service_apis, module.secret_github_token ]
}


module "secret_db_user" {
  source              =   "../../modules/e1_secret_manager"
  project_id          = var.project_id
  secret_id         = var.secret_id_db_user
  secret_data = var.secret_data_db_user
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}


module "secret_db_password" {
  source              =   "../../modules/e1_secret_manager"
  project_id          = var.project_id
  secret_id         = var.secret_id_db_password
  secret_data = random_password.db_password.result
}


