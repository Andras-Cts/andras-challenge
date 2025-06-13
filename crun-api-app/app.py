from flask import Flask, jsonify
import firebase_admin
from firebase_admin import firestore, credentials
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

cred = credentials.ApplicationDefault()
firebase_admin.initialize_app()

db = firestore.client(database_id="crc-db")


@app.route("/")
def visit():
    doc_ref = db.collection("visits").document("visitors")
    doc_ref.set({}, merge=True)
    doc_ref.update({"count": firestore.Increment(1)})

    doc = doc_ref.get()
    count = doc.to_dict().get("count", 0)

    return jsonify(count=count)


if __name__ == "__main__":
    app.run(debug=True)
