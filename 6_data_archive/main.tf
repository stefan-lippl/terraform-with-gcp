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