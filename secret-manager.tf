resource "google_secret_manager_secret" "cloudflare-api-token" {
  secret_id = "cloudflare-api-token"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

data "google_secret_manager_secret_version" "cloudflare-api-token" {
  project = var.project_id
  secret  = "cloudflare-api-token"
}