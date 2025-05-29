from flask import Flask, jsonify
import firebase_admin
from firebase_admin import firestore, credentials

app = Flask(__name__)

cred = credentials.ApplicationDefault()
firebase_admin.initialize_app()

db = firestore.client(database_id='crc-db')

@app.route("/")
def visit():
    doc_ref = db.collection("visits").document("visitors")
    doc_ref.set({}, merge=True)
    doc_ref.update({"count": firestore.Increment(1)})

    doc = doc_ref.get()
    count = doc.to_dict().get("count", 0)

    return jsonify(message=f"Your are visitor number: {count} on the webpage!")

if __name__ == "__main__":
    app.run(debug=True)
