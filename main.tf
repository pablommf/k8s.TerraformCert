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
  name                    = var.vpc_name
  auto_create_subnetworks = "false"
  mtu                     = 1500
}

# create subnet
resource "google_compute_subnetwork" "subnet_1" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr_1
  network       = var.vpc_name
  region        = var.gcp_region_1
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

# create Controlers
resource "google_compute_instance" "vm_controler_instance" {
  count        = var.controler_count
  name         = "controler-${count.index + 1}"
  machine_type = var.controler_machine_type
  zone         = var.gcp_zone_1
  hostname     = "controler-${count.index + 1}"
  tags         = ["kubernetes-the-hard-way", "controler"]

  boot_disk {
    initialize_params {
      image = var.controler_instance_image
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
    network_ip = "10.240.0.1${count.index + 1}"

    access_config {}
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "account-main@k8sterraformcert.iam.gserviceaccount.com"
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }

  metadata = {
    ssh-keys = <<EOF
      devops: file(var.devops_auth_file)
    EOF
  }
}


# create workers
resource "google_compute_instance" "vm_worker_instance" {
  count        = var.worker_count
  name         = "worker-${count.index + 1}"
  machine_type = var.worker_machine_type
  zone         = var.gcp_zone_1
  hostname     = "worker-${count.index + 1}"
  tags         = ["kubernetes-the-hard-way", "worker"]

  boot_disk {
    initialize_params {
      image = var.worker_instance_image
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
    network_ip = "10.240.0.2${count.index + 1}"

    access_config {}
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "account-main@k8sterraformcert.iam.gserviceaccount.com"
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
    metadata = {
    ssh-keys = <<EOF
      devops: file(var.devops_auth_file)
    EOF
  }
}

