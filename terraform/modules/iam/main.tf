#########################################
# modules/iam/main.tf – IAM Bindings    #
#########################################

resource "google_project_iam_member" "gcs" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${var.cloud_run_sa}"
}

resource "google_project_iam_member" "bq" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${var.cloud_run_sa}"
}

resource "google_project_iam_member" "run" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.cloud_run_sa}"
}

resource "google_project_iam_member" "run_invoker" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${var.cloud_run_sa}"
}

resource "google_project_iam_member" "composer" {
  project = var.project_id
  role    = "roles/composer.user"
  member  = "serviceAccount:${var.composer_sa}"
}
