resource "google_service_account" "terraform-sa" {
  description  = "Service account for Terraform"
  account_id   = "challenge-terraform-sa"
  display_name = "Challenge Terraform Service Account"
}


# resource "google_service_account" "challenge-lb" {
#   description  = "Service account for the Load Balancer"
#   account_id   = "challenge-lb-sa"
#   display_name = "Challenge LB Service Account"
# }

# resource "google_storage_bucket_iam_binding" "bucket-access" {
#   bucket = google_storage_bucket.challenge-webpage.name
#   role   = "roles/storage.admin"

#   members = ["serviceAccount:${google_service_account.challenge-lb.email}"]
# }