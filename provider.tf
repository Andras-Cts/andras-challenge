terraform {
  backend "gcs" {
    bucket = "andras-5am-challenge-tfstate-new"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=6.12.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=6.23.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.1.0"
    }
  }
}

provider "google" {
  project               = var.project_id
  region                = var.region
  billing_project       = var.project_id
  user_project_override = true
  # Enable ADC via OIDC token
  credentials = null
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "cloudflare" {
  api_token = data.google_secret_manager_secret_version.cloudflare-api-token.secret_data
}