/* No space around =
export TF_VAR_project_id="cog-run-lab"
export TF_VAR_project_number="146758086101"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region

#bucket_name = "should be unique"
*/

api_list  = [
    "cloudresourcemanager.googleapis.com",
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
]


secret_id_github = "github-token9"
#secret_data_github = "github-token-value"
secret_id_db_user = "db-user9"
secret_data_db_user = "db-user9"
secret_id_db_password = "db-password9"
#secret_data_db_password = "db-password9"

connection_name_github = "github-connection-cog"
app_installation_id_github = "55957239" 

github_account = "Mon8Cats"
github_repo_infra = "cog-run-infra"
github_repo_app = "cog-run-app"
repo_name_infra_gcp = "cog-run-infra"
#gcp_repo_app = "cog-run-app"

cicd_log_bucket_infra = "cog-run-infra-logs"


cicd_sa_name_infra = "sa-cicd-infra"

cicd_sa_infra_role_list = [
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