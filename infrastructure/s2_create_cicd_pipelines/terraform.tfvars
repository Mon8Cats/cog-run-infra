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

secret_id_github = "github-token"
secret_data_github = "github-token-value"

secret_id_db_user = "db-user"
secret_data_db_user = "db-user-value"

secret_id_db_password = "db-password"
#secret_data_db_password = "db-password-value"
