# Cloud Storage
variable "storage_name" {
  type = string 
  description = "Name of the Cloud Storage"
  default = "gcs-slippl-dev"
}

# Cloud Scheduler
variable "cron_expression"{
  type = string
  description = "Expression for the time the cron job should be triggered:"
  default = "0 5 * * 1"
}