resource "google_artifact_registry_repository" "andras-repo" {
  location      = var.region
  repository_id = "andras-crc"
  description   = "Repo for andras cloud run testing"
  format        = "DOCKER"
}