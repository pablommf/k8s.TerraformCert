# GCP Settings
project_name = "kubernetes-the-hard-way"
gcp_region_1  = "europe-west1"
gcp_zone_1    = "europe-west1-b"
gcp_auth_file = "../credentials/k8sTerraformCert.json"

# GCP Netwok
vpc_name = "kubernetes-the-hard-way"
subnet_name = "kubernetes"
subnet_cidr_1  = "10.240.0.0/24"
firewall_rules_external_name = "kubernetes-the-hard-way-allow-external"