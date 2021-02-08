# setup the GCP provider
terraform {
  required_version = ">= 0.12"
}
provider "google" {
  project     = "my-gcp-project"
  credentials = file("gcp_auth_file")
  region      = "gcp_region_1"
  zone        = "gcp_zone_1"
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