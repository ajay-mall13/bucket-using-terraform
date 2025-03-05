
provider "google" {
  credentials = file("alien-house-421716-666597119746")
  project     = "alien-house-421716"
  region      = "us-central1"
}


resource "google_storage_bucket" "my_bucket" {
  name          = "<BUCKET_NAME>"
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
