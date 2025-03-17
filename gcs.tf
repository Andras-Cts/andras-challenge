resource "google_storage_bucket" "cloud-challenge-tfstate" {
  name                        = "andras82-challenge-tfstate-new"
  location                    = var.region
  force_destroy               = false
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 120 # auto delete objects after 120 days
    }
  }

  #   public_access_prevention = "enforced"
}

resource "google_storage_bucket" "challenge-webpage" {
  name                        = "andras-challenge-webpage-new"
  location                    = var.region
  force_destroy               = false
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 120 # auto delete objects after 120 days
    }
  }
  cors {
    origin          = ["http://andras-challenge.co.uk"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
  # public_access_prevention = "enforced"   Uncomment later to play around with HTTPS LB
}

resource "google_compute_backend_bucket" "challenge-backend-bucket" {
  name        = "challenge-static-backend"
  description = "Backend for the website"
  bucket_name = google_storage_bucket.challenge-webpage.name
  enable_cdn  = true
}
