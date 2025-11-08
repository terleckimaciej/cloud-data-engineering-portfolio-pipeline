###################################
# variables.tf – global variables #
###################################


variable "project_id" {
type = string
description = "ID projektu GCP"
}


variable "data_lake_bucket_name" {
type = string
description = "Nazwa bucketa na GCS"
}


variable "cloud_run_sa" {
type = string
description = "Service Account dla Cloud Run"
}


variable "composer_sa" {
type = string
description = "Service Account dla Cloud Composer"
}


variable "dataproc_sa" {
type = string
description = "Service Account dla Dataproc"
}