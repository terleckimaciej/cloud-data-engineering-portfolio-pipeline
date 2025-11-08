variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "data_lake_bucket_name" {
  type        = string
  description = "Bucket used by Composer for DAGs and data"
}
