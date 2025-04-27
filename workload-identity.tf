# resource "google_iam_workload_identity_pool" "gh-actions-pool" {
#   workload_identity_pool_id = "gh-actions-identity-pool"
#   display_name              = "Github Actions Identity Pool"
#   description               = "Used to Authenticate to GCP"
# }

# resource "google_iam_workload_identity_pool_provider" "name" {
#   workload_identity_pool_id          = google_iam_workload_identity_pool.gh-actions-pool.workload_identity_pool_id
#   workload_identity_pool_provider_id = "github-actions-provider"
#   display_name                       = "Github Actions Provider"
#   description                        = "Used to Auth to GCP"
#   attribute_mapping = {
#     "google.subject"             = "assertion.sub",
#     "attribute.actor"            = "assertion.actor",
#     "attribute.repository"       = "assertion.repository",
#     "attribute.repository_owner" = "assertion.repository_owner"
#   }
#   attribute_condition = "assertion.repository == 'Andras-Cts/andras-challenge'"

#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }
# }