# Step by Step

## Create a GCP project

- IAM & Admin > Settings: get project name, project id, project number
- Cloud Shell > gcloud config set project [PROJECT_ID]

## Create/Config GitHub Repositories

- Create Repositories
- My account/ Settings/ Application/ Install Google Cloud Build and get application ID
- Developer settings / Personal access tokens / Generate classic token
  
## Create Cloud Storage Bucket for Terraform backend

- Enable APIs: cloudresourcemanager, storage.
- Create a unique bucket.

## Common Steps for CI-CD Pipeline

- Use the created bucket as Terraform backend.
  - if error happens, use: terraform init -reconfigure
- Enable APIs.
- Save sensitive date (GitHub token, DB User, DB Password) in Secret Manger. 
  - Check the saved secret: gcloud secrets versions access latest --secret=github-token
- Create github connection:
  - Require: github app installation id, github-token
  - Check: Cloud Build/ Repositories/ 2nd gen/ check connection 
- Create Workload Identity Pool
  - gcloud iam workload-identity-pools list --location=global
  - gcloud iam workload-identity-pools describe wip-499677090453  --location=global
  - name: projects/499677090453/locations/global/workloadIdentityPools/wip-499677090453

## Individual CI-CD Pipeline configuration

- Prerequisite: GitHub Connection, Workload Identity Pool
- Create a service account for the CI-CD pipeline.
- Create a bucket for Cloud Build log.
- Grant the service account access to the log bucket. 
- Grant the service account access to the secrets (GitHub token, DB User, DB Password).
-




```bash
gcloud iam workload-identity-pools list --location="global"
gcloud logging read 'resource.type="workload_identity_pool"' --limit 10
terraform import module.workload_identity_pool.google_iam_workload_identity_pool.github_pool "projects/<PROJECT_ID>/locations/global/workloadIdentityPools/<POOL_NAME>"
gcloud iam workload-identity-pools delete <POOL_NAME> --location="global"

 ```