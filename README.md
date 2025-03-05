# bucket-using-terraform

Overview

This project contains a Terraform script to create a Google Cloud Storage (GCS) bucket with versioning and a lifecycle rule to delete objects older than 30 days.

Prerequisites

Before running this script, ensure you have:

Terraform installed (Download Terraform)

Google Cloud SDK installed and authenticated (gcloud auth application-default login)

A valid GCP service account key JSON file

Set up billing and enabled the required APIs in GCP

Setup Instructions

1. Configure Terraform

Update the provider block in main.tf:

provider "google" {
  credentials = file("alien-house-421716-666597119746.json")
  project     = "alien-house-421716"
  region      = "us-central1"
}

Make sure the JSON credentials file exists in your working directory.

2. Update Bucket Configuration

Modify the following in main.tf:

resource "google_storage_bucket" "my_bucket" {
  name          = "<BUCKET_NAME>" # Change this to a unique bucket name
  location      = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # Delete objects older than 30 days
    }
  }

  force_destroy = true # Allow bucket deletion with objects inside
}

Replace <BUCKET_NAME> with your desired bucket name.

3. Initialize Terraform

Run the following command to initialize Terraform:

terraform init

4. Plan Deployment

To preview changes before applying, run:

terraform plan

5. Apply Changes

Deploy the bucket using:

terraform apply -auto-approve

6. Verify the Bucket

After successful deployment, verify the bucket exists:

gsutil ls -p alien-house-421716

7. Destroy the Bucket (If Needed)

To remove the created bucket, run:

terraform destroy -auto-approve

Notes

Ensure that the service account used has sufficient permissions (roles/storage.admin)

The bucket name must be globally unique

The lifecycle rule automatically deletes objects older than 30 days