# GCP Settings
project_name = "kubernetes-the-hard-way"
gcp_region_1  = "europe-west1"
gcp_zone_1    = "europe-west1-b"
gcp_auth_file = "../credentials/k8sTerraformCert.json"
devops_auth_file = "../credentials/devops.pub"

# GCP Netwok
vpc_name = "kubernetes-the-hard-way"
subnet_name = "kubernetes"
subnet_cidr_1  = "10.240.0.0/24"
firewall_rules_external_name = "kubernetes-the-hard-way-allow-external"

# GCP Controler Instance configuration
controler_count = "3"
controler_machine_type = "e2-standard-2"
controler_instance_image = "ubuntu-os-cloud/ubuntu-2004-lts"

# GCP Worker Instance configuration
worker_count = "3"
worker_machine_type = "e2-standard-2"
worker_instance_image = "ubuntu-os-cloud/ubuntu-2004-lts"