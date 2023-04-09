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
}
