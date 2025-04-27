resource "google_pubsub_topic" "budget-monitor-topic" {
  name                       = "Budget-watch-topic"
  message_retention_duration = "86400s"
  project                    = var.project_id
}

resource "google_pubsub_subscription" "budget-subscription" {
  name  = "budget-alert-subscription"
  topic = google_pubsub_topic.budget-monitor-topic.id

  ack_deadline_seconds = 30
}

# resource "google_pubsub_topic" "messaging-topic" {
#   name                       = "messaging-pubsub-topic"
#   message_retention_duration = "86400s"
#   project                    = var.project_id
# }

# resource "google_pubsub_subscription" "messaging-subscriber" {
#   name  = "messaging-pubsub-subscriper"
#   topic = google_pubsub_topic.budget-monitor-topic.id

#   ack_deadline_seconds = 30
# }