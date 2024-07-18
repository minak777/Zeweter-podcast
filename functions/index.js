const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.notifyNewEpisode = functions.firestore
    .document('podcasts/{podcastId}/episodes/{episodeId}')
    .onCreate(async (snap, context) => {
        const newEpisode = snap.data();
        const payload = {
            notification: {
                title: 'New Episode Available!',
                body: `${newEpisode.title} is now available.`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };

        const tokens = await admin.firestore().collection('users')
            .get()
            .then(snapshot => {
                let tokens = [];
                snapshot.forEach(doc => {
                    tokens.push(doc.data().fcmToken);
                });
                return tokens;
            });

        if (tokens.length > 0) {
            return admin.messaging().sendToDevice(tokens, payload);
        } else {
            console.log('No tokens available for notifications.');
            return null;
        }
    });

