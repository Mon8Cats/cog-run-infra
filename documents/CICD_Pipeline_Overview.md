# Build CICD Pipeline

## 1: Prepare GCP environment

1. Enable Required APIs:
   1. Cloud Build API
   2. Artifact Registry API
   3. Cloud Run, GCK,or Cloud Functions (depending on my deployment target)
   4. IAM Service Account Credentials
2. Set Up GCP Project and Permissions:
   1. Identify or create my GCP project.
   2. Create a service account with necessary roles (cloudbuild.build.builder, artifactregistry.writer, iam.serviceAccountUser, and deployment-specific roles).
   3. Configure Workload Identity Federation for GitHub to access GCP securely.
3. Create Infrastructure:
   1. Use Terraform to set up infrastructure like VPC, Cloud SQL, Kubernetes clusters, or Artifact Registry.

## 2: Prepare my GitHub Repository

1. Add Source Code:
   1. Ensure the repository contains my application code.
2. Create a cloudbuild.yaml file:
   1. Define build steps (build a Docker image, push it to Artifact Registry, and deploy to GCP services).

## 3: Set Up Cloud Build Trigger

1. Create GitHub Connection to Cloud Build:
   1. Set up a GitHub connection (require GitHub permissions and a personal access token).
2. Create a Trigger:
   1. Define Event, Branch/Tag, Build Configuration.

## 4: Secure my Pipeline

1. Secret Management:
   1. Store sensitive data in Secret Manager.
   2. Access them securely in the cloudbuild.yaml using environment variables.
2. IAM and Permissions:
   1. Limit permissions for the service accounts used in the pipeline to follow the principle of least privilege.

## 5: Test and Monitor

1. Trigger a Build:
   1. Push cod to the configured branch in GitHub or Manually start the trigger.
2. Verify Deployment:
3. Monitor Logs and Errors:

## 6: Automate Infrastructure (Optional) 

1. For a compete automated CI/CD pipeline, consider adding infrastructure provisioning via Terraform in a separate Cloud Build trigger.


