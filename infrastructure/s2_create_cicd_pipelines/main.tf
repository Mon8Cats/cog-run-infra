module "service_apis" {
  source                  = "../../modules/a1_service_apis"
  project_id  = var.project_id
  api_services = var.api_list
}

module "secret_manager_wrapper" {
  source  = "../../modules/e9_secret_manager_wrapper"
  project_id          = var.project_id
  project_number = var.project_number
  secret_id_github  = var.secret_id_github
  secret_data_github = var.secret_data_github
  secret_id_db_user = var.secret_id_db_user
  secret_data_db_user = var.secret_data_db_user
  secret_id_db_password = var.secret_id_db_user
}



