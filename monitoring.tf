resource "google_monitoring_notification_channel" "budget-watch" {
  display_name = "Notification channel"
  type         = "email"
  labels       = { email_address = "1.palandras@gmail.com" }
  force_delete = false
}

data "google_billing_account" "account" {
  billing_account = "013920-C33AB8-B6A496"
}

resource "google_billing_budget" "budget" {
  billing_account = data.google_billing_account.account.id
  display_name    = "Andras Challenge Project Billing Budget"
  amount {
    specified_amount {
      currency_code = "GBP"
      units         = "10"
    }
  }
  threshold_rules {
    threshold_percent = 3
    spend_basis       = "CURRENT_SPEND"
  }
  all_updates_rule {
    pubsub_topic = google_pubsub_topic.budget-monitor-topic.id
  }
}