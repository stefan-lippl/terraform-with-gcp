# Project
variable "project_id" {
  type        = string
  description = "The ID of the GCP project to use."
  default = "slippl-terraform-dev"
}

variable "region" {
  type = string
  description = "Default project region"
  default = ""
}

# Cloud Storage
variable "storage_name" {
  type = string
  description = "The name of the Cloud Storage"
  default = "gcs-slippl-terraform"
}