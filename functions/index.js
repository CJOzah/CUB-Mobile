// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");

admin.initializeApp(functions.config().firebase);

const fcm = admin.messaging();

exports.senddevices = functions.firestore
  .document("users/{id}/History/{id}")
  .onCreate((snapshot) => {
    const name = snapshot.get("senderName");
//    const subject = snapshot.get("subject");
    const token = snapshot.get("token");
    const amount = snapshot.get("amount");

    const payload = {
      notification: {
        title: "Credit Alert from " + name,
        body: "Your Account has been credited with " + amount + "click to check transaction details",
        sound: "default",
      },
    };

    return fcm.sendToDevice(token, payload);
  });