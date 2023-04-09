resource "google_service_account" "sa-slippl-dev" {
  account_id   = "sa-slippl-tf"
  display_name = "Service Account - Terraform project"
  description  = "This Service Account is used for the Terraform project" 
}