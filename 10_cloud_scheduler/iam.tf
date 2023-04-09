resource "google_project_iam_member" "cloud_functions_admin" {
  project = local.project_id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${google_service_account.sa-slippl-dev.email}"
}

resource "google_project_iam_member" "cloud_scheduler_invoker" {
  project = local.project_id
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.sa-slippl-dev.email}"
}