############################################
# modules/bigquery/main.tf – BigQuery     #
############################################

resource "google_bigquery_dataset" "jobs_dw" {
  dataset_id                  = "jobs_dw"
  project                     = var.project_id
  location                    = "europe-central2"
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset_iam_member" "cloud_run_access" {
  dataset_id = google_bigquery_dataset.jobs_dw.dataset_id
  project    = var.project_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${var.cloud_run_sa}"
}
