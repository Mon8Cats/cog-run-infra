locals {

  wi_pool_name_unique = "xxxwip"
  wi_pool_id = "${local.wi_pool_name_unique}-${var.project_number}"
  wi_pool_provider_id_infra = "${local.wi_pool_name_unique}-prid-infra-${var.project_number}"

  github_acct_repo_infra = "${var.github_account}/${var.github_repo_infra}"
  github_repo_uri_infra = "https://github.com/${local.github_acct_repo_infra}.git"

  service_account_email = "${var.cicd_sa_id_infra}@${var.project_id}.iam.gserviceaccount.com"
  
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
  source = "../../modules/g2_workload_identity_pool"
  project_id   = var.project_id
  wi_pool_id = local.wi_pool_id
  wi_pool_name= local.wi_pool_name_unique
}



module "cicd_pipeline_infra" {
  source = "../../modules/g9_cloudbuild_cicd_pipeline_wrapper"
  project_id = var.project_id
  region = var.region
  cicd_sa_id = var.cicd_sa_id_infra
  cicd_sa_role_list =  [
    "roles/cloudbuild.builds.editor",
    "roles/storage.admin",
    "roles/secretmanager.secretAccessor",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin",
    "roles/viewer",
    "roles/compute.admin",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/source.reader",
    "roles/cloudbuild.builds.builder",
    "roles/artifactregistry.admin",
    "roles/cloudsql.admin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin"
  ]
  cicd_log_bucket = var.cicd_log_bucket_infra

  secret_id_github_token = var.secret_id_github
  secret_id_db_user = var.secret_id_db_user
  secret_id_db_password = var.secret_id_db_password

  wip_name = module.workload_identity_pool.wip_name
  wip_short_id = module.workload_identity_pool.wip_short_id
  wip_provider_id = "wip-infra"
  github_acct_repo = "mon8cats/cog-run-infra"
  
  repo_name_gcp = var.github_repo_infra
  repo_uri_remote = local.github_repo_uri_infra
  repo_connection_name = module.github_connection.connection_name
} 


/*
# for individual ci-cd pipeline
module "workload_identity_pool_provider" {
  source = "../../modules/g2_workload_identity_pool_provider"
  project_id   = var.project_id
  # pool id only (no qualified name)
  wi_pool_id = module.workload_identity_pool.github_pool_short_id
  wi_pool_provider_id= local.wi_pool_provider_id_infra
  github_repository = local.github_acct_repo_infra
}


module "cicd_service_account" {
  source               = "../../modules/c1_service_account"
  project_id           = var.project_id
  service_account_name = var.cicd_sa_name_infra
  display_name         = "cicd Service Account"
  description          = "This service account is used for CI/CD operations"

  roles = var.cicd_sa_infra_role_list

}

module "cicd_log_bucket" {
  source                  = "../../modules/b1_storage_bucket"
  project_id              = var.project_id
  location                = var.region
  bucket_name             = var.cicd_log_bucket_infra
  storage_class           = "STANDARD"
  force_destroy           = true

  depends_on   = [module.cicd_service_account]
}

module "build_logs_bucket_iam_binding" {
  source           = "../../modules/b2_storage_bucket_iam_binding"
  bucket_name      = var.cicd_log_bucket_infra
  service_account_email   = local.service_account_email
  role             = "roles/storage.objectAdmin"

  depends_on   = [module.cicd_log_bucket]
}

module "github_token_secret_access" {
  source              = "../../modules/e3_secret_iam_member"
  secret_id = var.secret_id_github
  service_account_email = module.cicd_service_account.service_account_email

  depends_on   = [module.cicd_service_account]
}

module "github_repository_link" {
  source = "../../modules/g3_cloudbuild_repository_link"
  project_id = var.project_id
  region  = var.region
  connection_parent  = module.github_connection.connection_name
  repo_name_gcp = var.repo_name_infra_gcp
  repo_uri_remote = local.github_repo_uri_infra

}
*/