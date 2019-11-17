output "gke_cluster" {
  value = google_composer_environment.composer_env.config[0].gke_cluster
}

output "dag_gcs_prefix" {
  value = google_composer_environment.composer_env.config[0].dag_gcs_prefix
}

output "airflow_uri" {
  value = google_composer_environment.composer_env.config[0].airflow_uri
}