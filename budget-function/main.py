import base64
import json
import smtplib
from email.message import EmailMessage
import functions_framework
from google.cloud import secretmanager

def get_secret(secret_id: str, project_id: str = "andras-cv-challenge", version: str = "latest") -> str:
    client = secretmanager.SecretManagerServiceClient()
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version}"
    response = client.access_secret_version(name=name)
    return response.payload.data.decode("UTF-8")

@functions_framework.cloud_event
def pubsub_to_email(cloud_event):
    try:
        sender_email = get_secret("smtp-sender-email")
        app_password = get_secret("smtp-email-pass")
    except Exception as e:
        print(f"Failed to load secrets: {e}")
        return

    try:
        # Decode and parse Pub/Sub budget alert message
        message_data = base64.b64decode(cloud_event.data["message"]["data"]).decode("utf-8")
        budget_data = json.loads(message_data)

        # Extract fields from the budget alert
        budget_name = budget_data.get("budgetDisplayName", "Unknown Budget")
        cost = budget_data.get("costAmount", 0)
        budget_limit = budget_data.get("budgetAmount", 0)
        threshold = budget_data.get("alertThresholdExceeded", 0)
        currency = budget_data.get("currencyCode", "GBP")
        time = budget_data.get("timestamp", "Unknown Time")

        # Create email body
        body = (
            f"Billing Budget Alert!\n\n"
            f"Budget: {budget_name}\n"
            f"Current Cost: {cost} {currency}\n"
            f"Budget Limit: {budget_limit} {currency}\n"
            f"Threshold Exceeded: {threshold * 100}%\n"
            f"Time: {time}\n"
        )

        msg = EmailMessage()
        msg.set_content(body)
        msg["Subject"] = "⚠️ GCP Budget Alert Notification"
        msg["From"] = sender_email
        msg["To"] = "1.palandras@gmail.com"

        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
            smtp.login(sender_email, app_password)
            smtp.send_message(msg)

        print("Email sent successfully.")

    except Exception as e:
        print(f"Failed to process or send email: {e}")
