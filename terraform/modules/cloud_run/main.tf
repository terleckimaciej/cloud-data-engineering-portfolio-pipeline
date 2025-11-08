###############################################
# modules/cloud_run/main.tf – Cloud Run Jobs #
###############################################

resource "null_resource" "build_scraper_image" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud builds submit \
        --tag=gcr.io/${var.project_id}/pracuj-scraper \
        ../../cloudrun_jobs/scraper
    EOT
  }
}

resource "null_resource" "build_enricher_image" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud builds submit \
        --tag=gcr.io/${var.project_id}/pracuj-enricher \
        ../../cloudrun_jobs/enricher
    EOT
  }
}

resource "google_cloud_run_v2_job" "scraper" {
  name     = "pracuj-scraper-job"
  location = "europe-central2"
  project  = var.project_id

  template {
    template {
      containers {
        image = "gcr.io/${var.project_id}/pracuj-scraper"
        command = []

        resources {
          limits = {
            memory = "2Gi"
            cpu    = "1"
          }
        }
      }
      service_account = var.cloud_run_sa
    }
  }
  depends_on = [null_resource.build_scraper_image]
}

resource "google_cloud_run_v2_job" "enricher" {
  name     = "pracuj-enricher-job"
  location = "europe-central2"
  project  = var.project_id

  template {
    template {
      containers {
        image = "gcr.io/${var.project_id}/pracuj-enricher"
        command = []

        resources {
          limits = {
            memory = "4Gi"
            cpu    = "2"
          }
        }
      }
      service_account = var.cloud_run_sa
      timeout         = "25200s"  # 7h
    }
  }
  depends_on = [null_resource.build_enricher_image]
}