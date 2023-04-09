# Project
variable "project_id" {
  type = string
  description = "ID of the GCP project"
  default = "slippl-terraform-dev"
}

variable "region" {
  type = string
  description = "Default project region"
  default = "europe-west3"
}

# Service Account
variable "sa_name" {
  type = string
  description = "The name of the Service Account"
  default = "sa-slippl-tf"
}

variable "sa_display_name" {
  type = string
  description = "The name which should be displayed within the Service Account"
  default = "Service Account - Terraform project"
}

variable "sa_desc" {
  type = string
  description = "Description of the Service Account"
  default = "This Service Account is used for the Terraform project" 
}