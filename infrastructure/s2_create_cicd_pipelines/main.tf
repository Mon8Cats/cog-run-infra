locals {

  wi_pool_name = "wip"
  wi_pool_id = "${local.wi_pool_name}-${var.project_number}"
  wi_pool_provider_id_infra = "${local.wi_pool_name}-prid-infra-${var.project_number}"
  github_acct_repo_infra = "${var.github_account}/${var.github_repo_infra}"
}


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
  secret_id_db_password = var.secret_id_db_password
  secret_data_db_password = var.secret_data_db_password

  depends_on = [ module.service_apis ]
}

module "github_connection" {
  source = "../../modules/g1_cloudbuild_github_connection"

  project_id               = var.project_id
  region                   = var.region
  app_installation_id_github = var.app_installation_id_github
  secret_id_github = var.secret_id_github
  connection_name_github = var.connection_name_github

   depends_on = [ module.secret_manager_wrapper ]
}

module "workload_identity_pool" {
  source = "../../modules/g1_workload_identity_pool"
  project_id   = var.project_id
  wi_pool_id = local.wi_pool_id
  wi_pool_name= local.wi_pool_name
}


module "workload_identity_pool_provider" {
  source = "../../modules/g1_workload_identity_pool_provider"
  project_id   = var.project_id
  wi_pool_id = module.workload_identity_pool.github_pool_id
  wi_pool_provider_id= local.wi_pool_provider_id_infra
  github_repository = local.github_acct_repo_infra
}
