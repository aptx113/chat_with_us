const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { snapshotConstructor } = require("firebase-functions/v1/firestore");

admin.initializeApp();

exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((snap, context) => {
        admin
            .messaging()
            .sendToTopic('chat', {
                notifiacation: {
                    title: snapshot.data().username,
                    body: snap.data().text,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                },
            });
        return;
    });
