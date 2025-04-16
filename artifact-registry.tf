# resource "google_artifact_registry_repository" "challenge-repo" {
#   location      = var.region
#   repository_id = "challenge-repository"
#   description   = "Repository for my challenge project"
#   format        = "DOCKER"

#   docker_config {
#     immutable_tags = true
#   }
# }