# Cloud Storage
resource "random_string" "bucket_uuid" {
  length           = 6
  special          = false
  upper            = false
  min_lower        = 3
  min_numeric      = 3
}

resource "google_storage_bucket" "gcs_slippl" {
  name     = "${var.storage_name}-${random_string.bucket_uuid.result}"
  location = local.region
}

# Zip the py src code / whole code/ folder
data "archive_file" "archive" {
  type        = "zip"
  output_path = "${path.module}/${local.code_zip_name}.zip"
  source_dir  = "${path.module}/code"

  depends_on = [
    google_storage_bucket.gcs_slippl
  ]
}

# Cloud Storage Object - Python Code
resource "google_storage_bucket_object" "code" {
  name   = "${data.archive_file.archive.output_md5}.zip"
  source = data.archive_file.archive.output_path
  bucket = google_storage_bucket.gcs_slippl.id

  depends_on = [
    data.archive_file.archive
  ]
}

# Service Account
resource "google_service_account" "sa-slippl-dev" {
  account_id   = var.sa_name
  display_name = var.sa_display_name
  description  = var.sa_desc
}

# Cloud Function
resource "google_cloudfunctions_function" "cf_bq2conf" {
  name                  = local.cf_name
  runtime               = local.cf_runtime
  available_memory_mb   = local.cf_memory
  timeout               = local.cf_timeout
  max_instances         = local.cf_max_instances
  region                = local.region
  source_archive_bucket = google_storage_bucket.gcs_slippl.name
  source_archive_object = "${data.archive_file.archive.output_md5}.zip"
  entry_point           = local.cf_entry
  trigger_http          = local.cf_trigger

  project               = var.project_id
  service_account_email = google_service_account.sa-slippl-dev.email

  depends_on = [
    data.archive_file.archive,
    google_storage_bucket.gcs_slippl,
    google_storage_bucket_object.code
  ]
}

# Cloud Scheduler
resource "google_cloud_scheduler_job" "job" {
  name     = local.scheduler_name
  description = local.scheduler_desc
  region   = local.region
  schedule = var.cron_expression
  time_zone   = local.scheduler_time_zone
  http_target {
    http_method = local.scheduler_http_method
    uri         = google_cloudfunctions_function.cf_bq2conf.https_trigger_url
    oidc_token {
      service_account_email = google_service_account.sa-slippl-dev.email
    }
  }
  depends_on = [
    google_cloudfunctions_function.cf_bq2conf
  ]
}