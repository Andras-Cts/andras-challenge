# Make bucket public
resource "google_storage_bucket_iam_member" "member" {
  provider = google
  bucket   = google_storage_bucket.challenge-webpage.name
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}
resource "google_project_iam_member" "monitoring-editor" {
  project = var.project_id
  role    = "roles/monitoring.editor"
  member  = "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_pubsub_topic_iam_member" "billing-pubsub" {
  project = var.project_id
  topic   = google_pubsub_topic.budget-monitor-topic.name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:pubsub-billing-sa@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "serviceusage-admin" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "user:1.palandras@gmail.com"
}

resource "google_project_iam_member" "functions-sa-logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:messaging-pubsub-sa@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "messaging-pubsub-sa-email-access" {
  secret_id = google_secret_manager_secret.smtp-sender-email.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:messaging-pubsub-sa@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "messaging-pubsub-sa-pass-access" {
  secret_id = google_secret_manager_secret.smtp-email-pass.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:messaging-pubsub-sa@${var.project_id}.iam.gserviceaccount.com"
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

# resource "google_storage_bucket_iam_binding" "allow-lb-access" {
#   bucket = "andras-challenge-webpage-new"
#   role   = "roles/storage.objectViewer"

#   members = [
#     "serviceAccount:${var.project_id}@appspot.gserviceaccount.com",
#     "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com",
#     "serviceAccount:service-1078797412348@compute-system.iam.gserviceaccount.com",
#     "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
#   ]
# }

# resource "google_secret_manager_secret_iam_member" "challenge-tf-cloudflare-token-secret-accessor" {
#   project   = var.project_id
#   role      = "roles/secretmanager.secretAccessor"
#   secret_id = google_secret_manager_secret.cloudflare-api-token.secret_id
#   member    = "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"

# }



# resource "google_project_iam_binding" "terraform_sa_iam" {
#   project = var.project_id
#   role    = "roles/iam.securityAdmin"

#   members = [
#     "serviceAccount:challenge-terraform-sa@${var.project_id}.iam.gserviceaccount.com"
#   ]
# }

# resource "google_project_iam_binding" "grant-self-storage-admin" {
#   project = var.project_id
#   role    = "roles/storage.admin"

#   members = ["user:andras.pal@qodea.com"]

# }

# resource "google_project_iam_member" "assign-secret-manager-admin" {
#   project = var.project_id
#   role    = "roles/secretmanager.admin"

#   member = "user:andras.pal@qodea.com"
# }

# resource "google_project_iam_member" "self_sa_admin" {
#   project = var.project_id
#   role    = "roles/iam.serviceAccountAdmin"

#   member = "user:andras.pal@qodea.com"
# }

# resource "google_project_iam_member" "self-id-pool-admin" {
#   project = var.project_id
#   role    = "roles/iam.workloadIdentityPoolAdmin"

#   member = "user:andras.pal@qodea.com"
# }