# resource "google_cloud_run_v2_service" "challenge-run" {
#   name     = "challenge-cloudrun-service"
#   location = var.region
#   deletion_protection = false
#   ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

#   template {
#     containers {
#       image = "us-docker.pkg.dev/cloudrun/container/hello"
#     }
#     vpc_access{
#       connector = google_vpc_access_connector.connector.id
#       egress = "ALL_TRAFFIC"
#     }

#   }
# }

# resource "google_vpc_access_connector" "challenge-connector" {
#   name          = "challenge-run-vpc"
#   subnet {
#     name = google_compute_subnetwork.challenge-connector-subnet.name
#   }
#   machine_type = "e2-standard-4"
#   min_instances = 1
#   max_instances = 2
#   region        = var.region
# }
# resource "google_compute_subnetwork" "challenge-connector-subnet" {
#   name          = "run-subnetwork"
#   ip_cidr_range = "10.2.0.0/28"
#   region        = "us-central1"
#   network       = google_compute_network.challenge-connector-vpc.id
# }
# resource "google_compute_network" "challenge-connector-vpc" {
#   name                    = "run-network"
#   auto_create_subnetworks = false
# }