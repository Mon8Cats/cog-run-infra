/* No space around =
gcloud config set project mor-fun-lab
export TF_VAR_project_id="mor-fun-lab"
export TF_VAR_project_number="499677090453"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_project_number
echo $TF_VAR_region

#bucket_name = "should be unique"
*/


api_list  = [
    "cloudresourcemanager.googleapis.com", # enable this first
    "secretmanager.googleapis.com", 
    "storage.googleapis.com",
]

bucket_name_unique = "mor-fun-tf-backend" # globally unique name
