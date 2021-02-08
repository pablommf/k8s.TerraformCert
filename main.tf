# setup the GCP provider
terraform {
  required_version = ">= 0.12"
}
provider "google" {
  project     = var.app_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}


resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  mtu  = 1500
}

module "vm" {
  source  = "terraform-google-modules/vm/google"
  version = "6.0.0"
  #create 3 masters and 3 workers
}