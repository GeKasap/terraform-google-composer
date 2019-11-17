<<<<<<< HEAD
# Terraform  - Deploy a GCP Composer Environment (managed Airflow)
This project is an implementation of [Terraform Google Composer](https://www.terraform.io/docs/providers/google/r/composer_environment.html)
Layout. Deploys a composer environment and supports installation of additional `Pip` packages.

## How-to
Pre-requisites:
1. Create a Network with firewall rule that allows communication between the cluster nodes on all ports. You can use `terraform-google-network` module.
2. Create a service account with roles `roles/storage.objectViewer`, `roles/container.developer` and `roles/composer.worker`

### Example
```yaml
terraform {
  backend "gcs" {
    bucket  = "my-foo-bucket-tfstate"
    prefix  = "dataproc"
  }

  required_version = ">= 0.12"
}
provider "google-beta" {
  project = "my-foo-project"
  region  = "europe-west3"
  zone = "europe-west3-c"
}

module "my_foo_composer" {
  source = "./terraform-google-composer"
  name = var.composer_name
  project = var.project_id
  region = var.region
  node_count = 3
  zone = var.zone
  network = var.network
  service_account = var.service_account
  machine_type = "n1-standard-1"
}

```

## Variables
| Variable name | Type | Description | Default value |
| --- | --- | --- | --- |
| project | string | The project name |  |
| region | string | The region |  |
| labels | map(string) | Set of labels to identify the cluster | {} |
| name | string | The name of the Environment | my-unnamed-composer |
| node_count | number | The number of nodes in the Kubernetes Engine cluster that will be used to run this environment. | 1 |
| zone | string | The Compute Engine zone in which to deploy the VMs running the Apache Airflow software, specified as the zone name or relative resource name (e.g. `projects/{project}/zones/{zone}`). Must belong to the enclosing environment's project and region. | null |
| machine_type | string | The Compute Engine machine type used for cluster instances, specified as a name or relative resource name | n1-standard-1 |
| network | string | The Compute Engine network to be used for machine communications, specified as a self-link, relative resource name (e.g. `projects/{project}/global/networks/{network}`), by name. | null |
| subnetwork | string | The Compute Engine subnetwork to be used for machine communications, , specified as a self-link, relative resource name (e.g. `projects/{project}/regions/{region}/subnetworks/{subnetwork}`), or by name. | null |
| disk_size_gb | number | The disk size in GB used for node VMs. Minimum size is 20GB. If unspecified, defaults to 100GB. Cannot be updated. | 100  |
| oath_scopes | list(string) | The set of Google API scopes to be made available on all node VMs. Cannot be updated. | ["https://www.googleapis.com/auth/cloud-platform"]  |
| service_account | string | The service account for the cluster. The service account must have roles/composer.worker | null  |
| use_ip_aliases | bool | Whether or not to enable Alias IPs in the GKE cluster. If true, a VPC-native cluster is created. | null |
| cluster_secondary_range_name | bool | The name of the cluster's secondary range used to allocate IP addresses to pods. Specify either cluster_secondary_range_name or cluster_ipv4_cidr_block but not both. This field is applicable only when use_ip_aliases is true. | null |
| services_secondary_range_name | string | The name of the services' secondary range used to allocate IP addresses to the cluster. Specify either services_secondary_range_name or services_ipv4_cidr_block but not both. This field is applicable only when use_ip_aliases is true. | null |
| cluster_ipv4_cidr_block | string | The IP address range used to allocate IP addresses to pods in the cluster. Set to blank to have GKE choose a range with the default size. Set to /netmask (e.g. /14) to have GKE choose a range with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. Specify either cluster_secondary_range_name or cluster_ipv4_cidr_block but not both. | null |
| services_ipv4_cidr_block | string | The IP address range used to allocate IP addresses in this cluster. Set to blank to have GKE choose a range with the default size. Set to /netmask (e.g. /14) to have GKE choose a range with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use. Specify either services_secondary_range_name or services_ipv4_cidr_block but not both. | null |
| airflow_config_overrides | map(string) | Apache Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example `core-dags_are_paused_at_creation`. | {} |
| pip_packages | map(string) | A space separated list of pip packages to be installed | {} |
| env_variables | map(string) | Additional environment variables to provide to the Apache Airflow scheduler, worker, and webserver processes. Environment variable names must match the regular expression [a-zA-Z_][a-zA-Z0-9_]*. | {} |
| image_version | string | The version of the software running in the environment. This encapsulates both the version of Cloud Composer functionality and the version of Apache Airflow. It must match the regular expression composer-[0-9]+\\.[0-9]+(\\.[0-9]+)?-airflow-[0-9]+\\.[0-9]+(\\.[0-9]+.*)?.  | composer-1.8.0-airflow-1.10.3 |
| python_version | string | The major version of Python used to run the Apache Airflow scheduler, worker, and webserver processes. | 3 |
| enable_private_endpoint | bool | If true, access to the public endpoint of the GKE cluster is denied. | false |
| master_ip_cidr_block | string | The IP range in CIDR notation to use for the hosted master network. This range is used for assigning internal IP addresses to the cluster master or set of masters and to the internal load balancer virtual IP. This range must not overlap with any other ranges in use within the cluster's network. | null  |
| max_node_count | number | Maximum number of nodes of the additional pool | 10  |
| min_node_count | number | Minimum number of nodes of the additional pool | 0  |


## Building
### Initialization

```
$ terraform init
```

### Planning

Terraform allows you to "Plan", which allows you to see what it would change
without actually making any changes.

```
$ terraform plan 
```

### Applying

```
$ terraform apply
```

### Modifying

If you want to update the cluster, then edit the `terraform.tfvars` file and run again `terraform apply`
```
$ terraform apply
```

### Destroying
```
$ terraform destroy
```

# Author

Georgios Kasapoglou

https://github.com/GeKasap

# License

Copyright 2019 Georgios Kasapoglou

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=======
## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/GeKasap/terraform-google-composer/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/GeKasap/terraform-google-composer/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
>>>>>>> aba31b9f20b50e7198a9349c4eec90b599065b25
