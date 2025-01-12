resource "google_cloudbuildv2_repository" "my_repository" {
  location = var.region
  name = var.repo_name_gcp
  parent_connection = var.connection_parent
  remote_uri = var.repo_uri_remote
}


resource "google_cloudbuildv2_trigger" "my_trigger" {
  location = google_cloudbuildv2_repository.my_repository.location

  repository_event_config {
    repository = google_cloudbuildv2_repository.my_repository.name
    push {
      branches = ["main"] # Or other branches as needed
    }
  }

  filename = "cloudbuild.yaml" 
}

/*
resource "google_cloudbuild_trigger" "trigger" {
  project  = var.project_id
  name     = var.trigger_name
  #region   = var.region
  description = "Trigger to build and deploy using Cloud Build"
  filename = var.cloudbuild_yaml_path
  service_account = var.service_account_email
  #included_files = ["**"]
  ignored_files  = []
  disabled = false
  github {
    name       = google_cloudbuildv2_repository.my_repository.name
    owner      = var.github_account
    push {
      branch = var.branch_regex
    }
  }
}
*/