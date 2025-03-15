resource "google_storage_bucket_iam_binding" "allow-lb-access" {
  bucket = "andras-challenge-webpage-new"
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
  member    = "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"

}

resource "google_service_account_iam_member" "terraform-sa-workload-identity-user" {
  service_account_id = google_service_account.terraform-sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gh-actions-pool.name}/attribute.repository/Andras-Cts/andras-challenge"

}

resource "google_service_account_iam_member" "github-actions-token-creator" {
  service_account_id = google_service_account.terraform-sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gh-actions-pool.name}/attribute.repository/Andras-Cts/andras-challenge"
}

resource "google_project_iam_binding" "terraform_sa_iam" {
  project = var.project_id
  role    = "roles/iam.securityAdmin"

  members = [
    "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
  ]
}

# resource "google_project_iam_binding" "terraform_sa_identity_admin" {
#   project = var.project_id
#   role    = "roles/iam.workloadIdentityPoolAdmin"

#   members = [
#     "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
#   ]
# }

# resource "google_project_iam_binding" "terraform_sa_project_admin" {
#   project = var.project_id
#   role    = "roles/resourcemanager.projectIamAdmin"

#   members = [
#     "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
#   ]
# }


resource "google_project_iam_binding" "grant-self-storage-admin" {
  project = var.project_id
  role    = "roles/storage.admin"

  members = ["user:andras.pal@qodea.com"]

}

resource "google_project_iam_member" "assign-secret-manager-admin" {
  project = var.project_id
  role    = "roles/secretmanager.admin"

  member = "user:andras.pal@qodea.com"
}

resource "google_project_iam_member" "self_sa_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"

  member = "user:andras.pal@qodea.com"
}

resource "google_project_iam_member" "self-id-pool-admin" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityPoolAdmin"

  member = "user:andras.pal@qodea.com"
}