variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "cloud_run_sa" {
  type        = string
  description = "Service Account for Cloud Run access"
}

variable "composer_sa" {
  type        = string
  description = "Service Account for Composer access"
}
