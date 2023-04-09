resource "google_project_iam_member" "cloud_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.sa-slippl-dev.email}"
}