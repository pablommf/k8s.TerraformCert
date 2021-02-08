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

# create vpc
resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = "false"
  mtu  = 1500
}

# create subnet
resource "google_compute_subnetwork" "subnet_1" {
  name = var.subnet_name
  ip_cidr_range = var.subnet_cidr_1
  network = var.vpc_name
  region = var.gcp_region_1
}

# create firewall rules
resource "google_compute_firewall" "default" {
  name    = var.firewall_rules_external_name
  network = var.vpc_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_address" "static" {
  name = var.project_name
}

module "vm" {
  source  = "terraform-google-modules/vm/google"
  version = "6.0.0"
  #create 3 masters and 3 workers
}