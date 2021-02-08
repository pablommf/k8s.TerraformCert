# define project name
variable "project_name" {
  type = string
  description = "Project name"
}

# define the GCP authentication file
variable "gcp_auth_file" {
  type = string
  description = "GCP authentication file"
}

# define GCP project name
variable "app_project" {
  type = string
  description = "GCP project name"
}

# define GCP region
variable "gcp_region_1" {
  type = string
  description = "GCP region"
}

# define GCP zone
variable "gcp_zone_1" {
  type = string
  description = "GCP zone"
}

# define vpc
variable "vpc_name" {
  type = string
  description = "Name of VPC network"
}

# define subnet
variable "subnet_name" {
  type = string
  description = "Name of subnet"
}

# define subnet
variable "subnet_cidr_1" {
  type = string
  description = "Subnet CIDR 1"
}

# define firewall rules name
variable "firewall_rules_external_name" {
  type = string
  description = "Name of Firewall exterlnal rules"
}