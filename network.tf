# resource "google_compute_network" "challenge-network" {
#   description             = "The main network for the challenge"
#   name                    = "andras-challenge-network"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "challenge-subnet-one" {
#   description              = "Subnet for the challenge network"
#   name                     = "andras-challenge-subnet-one"
#   ip_cidr_range            = "192.168.80.0/24"
#   region                   = var.region
#   network                  = google_compute_network.challenge-network.id
#   private_ip_google_access = true
# }

# resource "google_compute_subnetwork" "challenge-subnet-two" {
#   description              = "Subnet for the challenge network"
#   name                     = "andras-challenge-subnet-two"
#   ip_cidr_range            = "192.168.96.0/24"
#   region                   = var.region
#   network                  = google_compute_network.challenge-network.id
#   private_ip_google_access = true
# }
