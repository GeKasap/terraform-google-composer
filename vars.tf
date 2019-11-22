variable "project" {
  type = string
  description = "The project name"
  default = ""
}

variable "region" {
  type = string
  description = "The region"
  default = ""
}

variable "labels" {
  type = map(string)
  description = "Set of labels to identify the cluster"
  default = {}
}

variable "name" {
  type = string
  description = "The name of the Environment"
  default = "my-unnamed-composer"
}

variable "node_count" {
  type = number
  description = "The number of nodes in the Kubernetes Engine cluster that will be used to run this environment."
  default = 1
}

# node_config
variable "zone" {
  type = string
  description = "The Compute Engine zone in which to deploy the VMs running the Apache Airflow software, specified as the zone name or relative resource name (e.g. `projects/{project}/zones/{zone}`). Must belong to the enclosing environment's project and region."
  default = null
}

variable "machine_type" {
  type = string
  description = "The Compute Engine machine type used for cluster instances, specified as a name or relative resource name"
  default = "n1-standard-1"
}

variable "network" {
  type = string
  description = "The Compute Engine network to be used for machine communications, specified as a self-link, relative resource name (e.g. `projects/{project}/global/networks/{network}`), by name."
  default = null
}

variable "subnetwork" {
  type = string
  description = "The Compute Engine subnetwork to be used for machine communications, , specified as a self-link, relative resource name (e.g. `projects/{project}/regions/{region}/subnetworks/{subnetwork}`), or by name."
  default = null
}

variable "disk_size_gb" {
  type = number
  description = "The disk size in GB used for node VMs. Minimum size is 20GB. If unspecified, defaults to 100GB. Cannot be updated."
  default = 100
}

variable "oath_scopes" {
  type = list(string)
  description = "The set of Google API scopes to be made available on all node VMs. Cannot be updated."
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "service_account" {
  type = string
  description = "The service account for the cluster. The service account must have roles/composer.worker"
  default = null
}

### ip_allocation_policy
variable "use_ip_aliases" {
  type = bool
  description = "Whether or not to enable Alias IPs in the GKE cluster. If true, a VPC-native cluster is created."
  default = true
}

variable "cluster_secondary_range_name" {
  type = bool
  description = "The name of the cluster's secondary range used to allocate IP addresses to pods. Specify either cluster_secondary_range_name or cluster_ipv4_cidr_block but not both. This field is applicable only when use_ip_aliases is true."
  default = null
}

variable "services_secondary_range_name" {
  type = string
  description = "The name of the services' secondary range used to allocate IP addresses to the cluster. Specify either services_secondary_range_name or services_ipv4_cidr_block but not both. This field is applicable only when use_ip_aliases is true."
  default = null
}

variable "cluster_ipv4_cidr_block" {
  type = string
  description = "The IP address range used to allocate IP addresses to pods in the cluster. Set to blank to have GKE choose a range with the default size. Set to /netmask (e.g. /14) to have GKE choose a range with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. Specify either cluster_secondary_range_name or cluster_ipv4_cidr_block but not both."
  default = null
}

variable "services_ipv4_cidr_block" {
  type = string
  description = "The IP address range used to allocate IP addresses in this cluster. Set to blank to have GKE choose a range with the default size. Set to /netmask (e.g. /14) to have GKE choose a range with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. Specify either services_secondary_range_name or services_ipv4_cidr_block but not both."
  default = null
}
#software_config
variable "airflow_config_overrides" {
  type = map(string)
  description = "Apache Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example `core-dags_are_paused_at_creation`."
  default = {}
}

variable "pip_packages" {
  type = map(string)
  description = "A space separated list of pip packages to be installed"
  default = {}
}

variable "env_variables" {
  type = map(string)
  description = "Additional environment variables to provide to the Apache Airflow scheduler, worker, and webserver processes. Environment variable names must match the regular expression [a-zA-Z_][a-zA-Z0-9_]*."
  default = {}
}

variable "image_version" {
  type = string
  description = "The version of the software running in the environment. This encapsulates both the version of Cloud Composer functionality and the version of Apache Airflow. It must match the regular expression composer-[0-9]+\\.[0-9]+(\\.[0-9]+)?-airflow-[0-9]+\\.[0-9]+(\\.[0-9]+.*)?. "
  default = "composer-1.8.0-airflow-1.10.3"
}

variable "python_version" {
  type = string
  description = "The major version of Python used to run the Apache Airflow scheduler, worker, and webserver processes."
  default = "3"
}


#private_environment_config
variable "enable_private_endpoint" {
  type = bool
  description = "If true, access to the public endpoint of the GKE cluster is denied."
  default = false
}

variable "master_ip_cidr_block" {
  type = string
  description = "The IP range in CIDR notation to use for the hosted master network. This range is used for assigning internal IP addresses to the cluster master or set of masters and to the internal load balancer virtual IP. This range must not overlap with any other ranges in use within the cluster's network."
  default = null
}

variable "max_node_count" {
  type = number
  description = "Maximum number of nodes of the additional pool"
  default = 10
}

variable "min_node_count" {
  type = number
  description = "Minimum number of nodes of the additional pool"
  default = 0
}

