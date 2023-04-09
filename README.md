# Terraform
## Configuration

This Terraform configuration consists of several components, organized in separate files for better organization and readability. The following files are included:

1. create_service_account.tf
This file contains the google_service_account resource block, which creates a service account in your GCP project.


    ```hcl
    resource "google_service_account" "example" {
    account_id   = "example-service-account"
    display_name = "Example Service Account"
    }
    ```

2. assign_role_to_service_account.tf
This file contains the google_project_iam_member resource block, which assigns the "Cloud Storage Admin" role to the previously created service account.

    ```hcl
    resource "google_project_iam_member" "example" {
    project = var.project_id
    role    = "roles/storage.admin"

    member = "serviceAccount:${google_service_account.example.email}"
    }
    ```

3. variables.tf
This file contains the variable declarations, such as the GCP project ID.

    ```hcl
    variable "project_id" {
    description = "The ID of the GCP project where the service account and role assignment will be created."
    type        = string
    }
    ```

4. locals.tf (optional)
This file contains the local values for your Terraform configuration. Locals are used to define reusable expressions or values that can be referenced throughout your configuration.

    ```hcl
    locals {
    // Define your local values here
    }
    ```

<br>

## Usage

To use this Terraform configuration, make sure to replace `<YOUR_PROJECT_ID>` with your actual GCP project ID in the `variables.tf` file or provide it when running `terraform apply` command as a `-var` argument.

Initialize the Terraform working directory by running `terraform init`. Then, execute `terraform plan` to preview the changes that will be made, and finally, apply the changes by running `terraform apply`.