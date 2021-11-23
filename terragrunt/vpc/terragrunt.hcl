terraform {
  source = "tfr:///terraform-google-modules/network/google?version=4.0.1"
}

locals {
  config = yamldecode(file("${find_in_parent_folders("config.yaml")}"))
}

inputs = {
  project_id                = local.config.project
  network_name              = local.config.name
  network_name_for_firewall = local.config.name
  project_for_firewall      = local.config.project

  subnets = [
    {
      subnet_name   = local.config.name
      subnet_ip     = local.config.vpc.subnetCidr
      subnet_region = local.config.region
    }
  ]

  secondary_ranges = {
    (local.config.name) = [
      {
        range_name    = "${local.config.name}-pods"
        ip_cidr_range = local.config.vpc.podsSecondaryCidr
      },
      {
        range_name    = "${local.config.name}-services"
        ip_cidr_range = local.config.vpc.servicesSecondaryCidr
      },
    ]
  }
}
