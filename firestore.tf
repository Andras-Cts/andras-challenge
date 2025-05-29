resource "google_firestore_database" "backend-db" {
  project     = var.project_id
  name        = "crc-db"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
}