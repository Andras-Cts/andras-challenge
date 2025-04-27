# locals {
#   project       = "andras-cv-challenge" # GCP Project ID
#   budget_folder = "${local.project}-budget-alert"
# }

resource "google_storage_bucket" "func-bucket" {
  name                        = "${local.project}-gcf-source"
  location                    = "EU"
  uniform_bucket_level_access = true
}

# resource "google_storage_bucket_object" "object" {
#   name   = "msg-test-function-${filesha256("function-source.zip")}.zip"
#   bucket = google_storage_bucket.func-bucket.name
#   source = "function-source.zip" # Add path to the zipped function source code
# }

resource "google_storage_bucket_object" "budget-function-object" {
  name   = "${local.budget_folder}/budget-function-${filesha256("budget-function/budget-function.zip")}.zip"
  bucket = google_storage_bucket.func-bucket.name
  source = "budget-function/budget-function.zip" # path to the zipped function source code
}

# resource "google_cloudfunctions2_function" "function" {
#   name        = "messaging-test-func-v2"
#   location    = var.region
#   description = "Messaging test function"

#   build_config {
#     runtime     = "python313"
#     entry_point = "pubsub_to_email" # entry point for the function
#     source {
#       storage_source {
#         bucket = google_storage_bucket.func-bucket.name
#         object = google_storage_bucket_object.object.name
#       }
#     }
#   }

#   event_trigger {
#     trigger_region = var.region
#     event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
#     pubsub_topic   = google_pubsub_topic.messaging-topic.id
#     retry_policy   = "RETRY_POLICY_DO_NOT_RETRY"
#   }

#   service_config {
#     max_instance_count    = 1
#     available_memory      = "256M"
#     timeout_seconds       = 60
#     service_account_email = google_service_account.messaging-pubsub-sa.email
#   }
# }

resource "google_cloudfunctions2_function" "budget-alert-function" {
  name        = "budget-alert-func"
  location    = var.region
  description = "Budget alert email notification function"

  build_config {
    runtime     = "python313"
    entry_point = "pubsub_to_email" # entry point for the function
    source {
      storage_source {
        bucket = google_storage_bucket.func-bucket.name
        object = google_storage_bucket_object.budget-function-object.name
      }
    }
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.budget-monitor-topic.id
    retry_policy   = "RETRY_POLICY_RETRY"
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.messaging-pubsub-sa.email
  }
}