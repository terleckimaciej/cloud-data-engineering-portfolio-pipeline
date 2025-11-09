#################################################
# modules/composer/main.tf – Cloud Composer v2 #
#################################################

resource "google_project_service" "composer" {
  service            = "composer.googleapis.com"
  project            = var.project_id
  disable_on_destroy = false
}

resource "google_composer_environment" "env" {
  name    = "pracuj-composer"
  project = var.project_id
  region  = "europe-central2"
  depends_on = [google_project_service.composer]

  config {
    node_count = 3

    software_config {
      image_version = "composer-2.4.4-airflow-2.7.1"
      env_variables = {
        PROJECT_ID            = var.project_id
        BUCKET_NAME           = var.data_lake_bucket_name
        CLOUD_RUN_SCRAPER_JOB = "pracuj-scraper-job"
        CLOUD_RUN_ENRICHER_JOB = "pracuj-enricher-job"
        DATASET_NAME          = "jobs_dw"
        TABLE_NAME            = "curated_jobs"
      }
    }
  }
}


# Upload DAG to Composer bucket
resource "google_storage_bucket_object" "dag_pipeline" {
  name   = "dags/${basename(var.dag_source_path)}"
  bucket = var.composer_bucket_name
  source = var.dag_source_path
  depends_on = [google_composer_environment.env]
}
