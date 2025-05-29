resource "google_secret_manager_secret" "cloudflare-api-token" {
  secret_id = "cloudflare-api-token"
  replication {
    user_managed {
      replicas {
        location = "europe-west1"
      }
    }
  }
}

data "google_secret_manager_secret_version" "cloudflare-api-token" {
  project = var.project_id
  secret  = "cloudflare-api-token"
}

resource "google_secret_manager_secret" "smtp-sender-email" {
  secret_id = "smtp-sender-email"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret" "smtp-email-pass" {
  secret_id = "smtp-email-pass"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}
