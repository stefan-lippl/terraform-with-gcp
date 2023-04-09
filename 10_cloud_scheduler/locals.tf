locals {
  # project
  region = "europe-west3"
  project_id = "slippl-terraform-dev"

  # code
  code_zip_name = "slippl_code"

  # cloud function
  cf_name = "cf-bg2conf"
  cf_runtime = "python310"
  cf_memory = 256
  cf_timeout = 540
  cf_max_instances = 1
  cf_entry = "main"
  cf_trigger = true

  # cloud scheduler
  scheduler_name = "cs-trigger-bg2conf"
  scheduler_desc = "Cloud Scheduler for CES BG2CONF to trigger the Cloud Function"
  scheduler_time_zone = "Europe/Berlin"
  scheduler_http_method = "POST"
}
