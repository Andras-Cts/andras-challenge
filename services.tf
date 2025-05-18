resource "google_project_service" "billing-budget" {
  project = var.project_id
  service = "billingbudgets.googleapis.com"
}

resource "google_project_service" "cloud-billing" {
  project = var.project_id
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "resourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "iam-apis" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "pub-sub-api" {
  project = var.project_id
  service = "pubsub.googleapis.com"
}

resource "google_project_service" "functions-api" {
  project = var.project_id
  service = "cloudfunctions.googleapis.com"
}

resource "google_project_service" "cloudrun-admin-api" {
  project = var.project_id
  service = "run.googleapis.com"
}

resource "google_project_service" "secretmanager-api" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

resource "google_project_service" "cloudbuild-api" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "eventarc-publishing-api" {
  project = var.project_id
  service = "eventarcpublishing.googleapis.com"
}

resource "google_project_service" "compute-engine-api" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "certificatemanager-api" {
  project = var.project_id
  service = "certificatemanager.googleapis.com"
}

resource "google_project_service" "dns-api" {
  project = var.project_id
  service = "dns.googleapis.com"
}
resource "google_project_service" "firestore-api" {
  project = var.project_id
  service = "firestore.googleapis.com"
}