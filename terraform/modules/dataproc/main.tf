############################################
# modules/dataproc/main.tf – Dataproc IAM #
############################################

resource "google_project_service" "dataproc" {
  service = "dataproc.googleapis.com"
  project = var.project_id
  disable_on_destroy = false
}

resource "google_project_iam_member" "composer_dataproc_access" {
  project = var.project_id
  role    = "roles/dataproc.editor"
  member  = "serviceAccount:${var.composer_sa}"
  depends_on = [google_project_service.dataproc]
}
