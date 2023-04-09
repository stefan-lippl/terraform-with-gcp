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
  location = var.region
}