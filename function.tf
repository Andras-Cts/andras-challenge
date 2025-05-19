# locals {
#   project       = "andras-cv-challenge" # GCP Project ID
#   budget_folder = "${local.project}-budget-alert"
# }

resource "google_storage_bucket" "func-bucket" {
  name                        = "${local.project}-gcf-source"
  location                    = "EU"
  uniform_bucket_level_access = true
}


resource "google_storage_bucket_object" "budget-function-object" {
  name   = "${local.budget_folder}/budget-function-${filesha256("budget-function/budget-function.zip")}.zip"
  bucket = google_storage_bucket.func-bucket.name
  source = "budget-function/budget-function.zip" # path to the zipped function source code
}

# resource "google_storage_bucket_object" "backend-function-object" {
#   name   = "${path.module}/backend-function-${filesha256("backend-function/backend-function.zip")}.zip"
#   bucket = google_storage_bucket.func-bucket.name
#   source = "${path.module}/backend-function/backend-function.zip" # path to the zipped function source code
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

resource "google_cloud_run_service" "backend-test" {
  name     = "andras-backend-test"
  location = var.region

  template {
    spec {
      containers {
        image = "europe-west2-docker.pkg.dev/andras-cv-challenge/andras-crc/andras-test-image:latest"
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.backend-test.location
  project  = google_cloud_run_service.backend-test.project
  service  = google_cloud_run_service.backend-test.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

# resource "google_cloudfunctions2_function" "backend-function" {
#   name        = "backend-func"
#   location    = var.region
#   description = "Testing API function to backend"

#   build_config {
#     runtime     = "python313"
#     entry_point = "hello_world" # entry point for the function
#     source {
#       storage_source {
#         bucket = google_storage_bucket.func-bucket.name
#         object = google_storage_bucket_object.backend-function-object.name
#       }
#     }
#   }

#   # event_trigger {
#   #   trigger_region = var.region
#   #   event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
#   #   pubsub_topic   = google_pubsub_topic.budget-monitor-topic.id
#   #   retry_policy   = "RETRY_POLICY_RETRY"
#   # }

#   service_config {
#     max_instance_count    = 1
#     available_memory      = "256M"
#     timeout_seconds       = 60
#     service_account_email = google_service_account.messaging-pubsub-sa.email
#   }
# }

# resource "google_storage_bucket_object" "object" {
#   name   = "msg-test-function-${filesha256("function-source.zip")}.zip"
#   bucket = google_storage_bucket.func-bucket.name
#   source = "function-source.zip" # Add path to the zipped function source code
# }

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
