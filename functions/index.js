const { onRequest } = require("firebase-functions/v2/https");
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendManualNotification = onRequest(async (req, res) => {
  const { title, body, token, topic } = req.body;

  if (!title || !body) {
    return res.status(400).send("Title and body are required.");
  }

  let message = {
    notification: { title, body },
    data: { click_action: "FLUTTER_NOTIFICATION_CLICK" },
  };

  if (token) {
    message.token = token;
  } else if (topic) {
    message.topic = topic;
  } else {
    return res.status(400).send("Provide either 'token' or 'topic'.");
  }

  await admin.messaging().send(message);
  res.send("Notification sent successfully.");
});
