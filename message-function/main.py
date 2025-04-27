import base64
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
        print(f" Failed to load secrets: {e}")
        return

    try:
        # Decode Pub/Sub message
        data = base64.b64decode(cloud_event.data["message"]["data"]).decode("utf-8")

        # Create email
        msg = EmailMessage()
        msg.set_content(f"Pub/Sub message received:\n\n{data}")
        msg["Subject"] = "Pub/Sub Alert"
        msg["From"] = sender_email
        msg["To"] = "1.palandras@gmail.com"

        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
            smtp.login(sender_email, app_password)
            smtp.send_message(msg)

        print(" Email sent successfully.")

    except Exception as e:
        print(f" Failed to send email: {e}")
