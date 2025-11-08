variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "composer_sa" {
  type        = string
  description = "Service Account for Composer access to Dataproc"
}
