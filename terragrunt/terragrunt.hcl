remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "tf-state-gke-testing"
    prefix = "terraform/${path_relative_to_include()}/"
  }
}