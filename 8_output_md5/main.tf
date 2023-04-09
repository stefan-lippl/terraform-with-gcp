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
}

# Cloud Storage Object - Python Code
resource "google_storage_bucket_object" "code" {
  name   = "${data.archive_file.archive.output_md5}.zip"
  source = data.archive_file.archive.output_path
  bucket = google_storage_bucket.gcs_slippl.id
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
}