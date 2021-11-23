terraform {
  source = "tfr:///terraform-google-modules/kubernetes-engine/google?version=17.2.0"
}

locals {
  config = yamldecode(file("${find_in_parent_folders("config.yaml")}"))
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    network_name  = "my-mock-network"
    subnets_names = [
      "my-mock_subnet-1",
      "my-mock_subnet-2",
      "my-mock_subnet-3",
    ]
  }
}

inputs = {
  project_id             = local.config.project
  name                   = local.config.name
  regional               = true
  region                 = local.config.region
  network                = dependency.vpc.outputs.network_name
  subnetwork             = dependency.vpc.outputs.subnets_names[0]
  ip_range_pods          = "${local.config.name}-pods"
  ip_range_services      = "${local.config.name}-services"
  create_service_account = true
}
