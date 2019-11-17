resource "google_composer_environment" "composer_env" {
  name = var.name
  region = var.region
  labels = var.labels
  project = var.project
  config {
    node_count = var.node_count
    node_config {
      zone = var.zone
      machine_type = "projects/${var.project}/zones/${var.zone}/machineTypes/${var.machine_type}"
      network = var.network
      subnetwork = var.subnetwork
      service_account = var.service_account
      disk_size_gb = var.disk_size_gb
      oauth_scopes = var.oath_scopes
      ip_allocation_policy {
        cluster_secondary_range_name = var.cluster_secondary_range_name
        services_secondary_range_name = var.services_secondary_range_name
        cluster_ipv4_cidr_block = var.cluster_ipv4_cidr_block
        services_ipv4_cidr_block = var.services_ipv4_cidr_block
      }
    }
    software_config {
      pypi_packages = var.pip_packages
      airflow_config_overrides = var.airflow_config_overrides
      env_variables = var.env_variables
      image_version = var.image_version
      python_version = var.python_version
    }
    private_environment_config {
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block = var.master_ip_cidr_block
    }
  }
}

