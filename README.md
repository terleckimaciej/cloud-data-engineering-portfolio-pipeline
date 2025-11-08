# Cloud Data Engineering Portfolio Pipeline (GCP)

This project showcases a full-stack data engineering pipeline deployed on **Google Cloud Platform**, designed for scalability and modularity. It covers raw data ingestion, enrichment, processing, and warehousing, built entirely as infrastructure-as-code with **Terraform**.

---

## 🔧 Tech Stack
- **GCP Services:**
  - Cloud Run (Jobs)
  - Cloud Composer (Airflow)
  - Dataproc (PySpark)
  - BigQuery
  - GCS (Data Lake)
  - Artifact Registry
  - IAM
- **Infrastructure:**
  - Terraform (modular structure)
  - Docker (for job containers)

---

## 🧱 Infrastructure Modules (Terraform)

Each module is defined in `/terraform/modules/<module>`

| Module     | Description |
|------------|-------------|
| `gcs`      | Creates GCS bucket `pracuj-pl-data-lake` with folders for `raw/`, `curated/`, `enriched/`, and `pyspark_jobs/` |
| `cloud_run` | Builds and deploys Cloud Run jobs: `pracuj-scraper-job`, `pracuj-enricher-job` |
| `bigquery` | Creates dataset `jobs_dw` |
| `composer` | Deploys Composer v2 with Airflow 2.7.1, 3 workers, env vars for pipeline execution |
| `dataproc` | Enables Dataproc API and allows Composer to access it |
| `iam`      | Grants required roles to all service accounts |

---

## 🧪 Pipeline Overview

1. **Cloud Run Job (Scraper)**
   - Scrapes job postings and stores raw data to `GCS/raw/`

2. **Cloud Run Job (Enricher)**
   - Reads raw jobs, enriches them and stores to `GCS/curated/`

3. **Airflow DAG (Composer)**
   - Orchestrates job triggering and processing flow
   - Uploads final data to BigQuery table `jobs_dw.curated_jobs`

4. **PySpark (Dataproc)**
   - Handles scalable enrichment logic if required (run by DAG)

---

## 🚀 Deployment

### Prerequisites:
- GCP project set up
- `gcloud` and `terraform` CLI installed
- Enabled APIs: Cloud Run, Composer, Dataproc, BigQuery, Artifact Registry, IAM

### Deploy steps:
```bash
cd terraform
terraform init
terraform apply
```

Modules can be tested in isolation using `--target=module.<name>`.

---

## 📁 Project Structure
```
├── cloudrun_jobs/        # Dockerized scraper and enricher jobs
├── dags/                 # Airflow DAG
├── pyspark_jobs/         # Spark enrichment logic (optional)
├── scripts/load_bq.py    # Script for loading data into BigQuery
├── terraform/            # Full IaC setup (modular Terraform)
```

---

## 🔐 Notes
- `.terraform/`, `terraform.tfstate` and `.tfstate.backup` are excluded via `.gitignore`
- Terraform creates the bucket and folders, jobs, Composer env, IAM bindings, BQ dataset
- You can trigger job runs manually using:
```bash
gcloud run jobs execute pracuj-scraper-job --region europe-central2
gcloud run jobs execute pracuj-enricher-job --region europe-central2
```

---

## 📌 Author
Maciej Terlecki – 2025

---

For questions or detailed breakdown, see the [project plan](./Plan%20projektu%20data%20engineeringowego%20na%20GCP%20(portfolio).docx)
