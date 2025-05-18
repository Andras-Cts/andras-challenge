resource "google_firestore_database" "datastore_mode_database" {
  project     = var.project_id
  name        = "crc-db"
  location_id = var.region
  type        = "DATASTORE_MODE"
}