resource "google_storage_bucket_iam_binding" "allow-lb-access" {
  bucket = "andras-challenge-webpage"
  role   = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${var.project_id}@appspot.gserviceaccount.com",
    "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com",
  ]
}

resource "google_secret_manager_secret_iam_member" "challenge-tf-cloudflare-token-secret-accessor" {
  project   = var.project_id
  role      = "roles/secretmanager.secretAccessor"
  secret_id = google_secret_manager_secret.cloudflare-api-token.secret_id
  member = "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"

}

resource "google_project_iam_binding" "terraform_sa_iam" {
  project = var.project_id
  role    = "roles/iam.securityAdmin"

  members = [
    "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_member" "assign-secret-manager-admin" {
  project = var.project_id
  role = "roles/secretmanager.admin"

  member = "user:andras.pal@qodea.com"
}
