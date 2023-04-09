# Service Account
resource "google_service_account" "sa-slippl-dev" {
  account_id   = var.sa_name
  display_name = var.sa_display_name
  description  = var.sa_desc
}