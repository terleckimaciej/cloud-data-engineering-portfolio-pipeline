############################################
# modules/gcs/variables.tf – Input Variables
############################################

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "bucket_name" {
  type        = string
  description = "Name of the GCS bucket"
}

variable "cloud_run_sa" {
  type        = string
  description = "Service Account used by Cloud Run jobs"
}

variable "composer_sa" {
  type        = string
  description = "Service Account used by Cloud Composer"
}

variable "dataproc_sa" {
  type        = string
  description = "Service Account used by Dataproc jobs"
}
