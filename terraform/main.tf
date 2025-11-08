###########################
# main.tf – main modules loading #
###########################

terraform {
required_version = ">= 1.4.0"


required_providers {
google = {
source = "hashicorp/google"
version = ">= 4.64.0"
}
}
}


provider "google" {
project = var.project_id
region = "europe-central2"
}


provider "google-beta" {
project = var.project_id
region = "europe-central2"
}


module "gcs" {
  source = "./modules/gcs"

  project_id             = var.project_id
  bucket_name            = var.data_lake_bucket_name
  cloud_run_sa           = var.cloud_run_sa
  composer_sa            = var.composer_sa
  dataproc_sa            = var.dataproc_sa
}


module "cloud_run" {
source = "./modules/cloud_run"
project_id = var.project_id
cloud_run_sa = var.cloud_run_sa
}


module "bigquery" {
source = "./modules/bigquery"
project_id = var.project_id
cloud_run_sa = var.cloud_run_sa
}


module "dataproc" {
source = "./modules/dataproc"
project_id = var.project_id
composer_sa = var.composer_sa
}


module "composer" {
source = "./modules/composer"
project_id = var.project_id
data_lake_bucket_name = var.data_lake_bucket_name
}


module "iam" {
source = "./modules/iam"
project_id = var.project_id
cloud_run_sa = var.cloud_run_sa
composer_sa = var.composer_sa
}