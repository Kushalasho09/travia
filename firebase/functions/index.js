const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "ff_push_notifications";
const firestore = admin.firestore();

const kPushNotificationRuntimeOpts = {
  timeoutSeconds: 540,
  memory: "2GB",
};

exports.addFcmToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return "Failed: Unauthenticated calls are not allowed.";
  }
  const userDocPath = data.userDocPath;
  const fcmToken = data.fcmToken;
  const deviceType = data.deviceType;
  if (
    typeof userDocPath === "undefined" ||
    typeof fcmToken === "undefined" ||
    typeof deviceType === "undefined" ||
    userDocPath.split("/").length <= 1 ||
    fcmToken.length === 0 ||
    deviceType.length === 0
  ) {
    return "Invalid arguments encoutered when adding FCM token.";
  }
  if (context.auth.uid != userDocPath.split("/")[1]) {
    return "Failed: Authenticated user doesn't match user provided.";
  }
  const existingTokens = await firestore
    .collectionGroup(kFcmTokensCollection)
    .where("fcm_token", "==", fcmToken)
    .get();
  var userAlreadyHasToken = false;
  for (var doc of existingTokens.docs) {
    const user = doc.ref.parent.parent;
    if (user.path != userDocPath) {
      // Should never have the same FCM token associated with multiple users.
      await doc.ref.delete();
    } else {
      userAlreadyHasToken = true;
    }
  }
  if (userAlreadyHasToken) {
    return "FCM token already exists for this user. Ignoring...";
  }
  await getUserFcmTokensCollection(userDocPath).doc().set({
    fcm_token: fcmToken,
    device_type: deviceType,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return "Successfully added FCM token!";
});

exports.sendPushNotificationsTrigger = functions
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      await sendPushNotifications(snapshot);
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

async function sendPushNotifications(snapshot) {
  const notificationData = snapshot.data();
  const title = notificationData.notification_title || "";
  const body = notificationData.notification_text || "";
  const imageUrl = notificationData.notification_image_url || "";
  const sound = notificationData.notification_sound || "";
  const parameterData = notificationData.parameter_data || "";
  const targetAudience = notificationData.target_audience || "";
  const initialPageName = notificationData.initial_page_name || "";
  const userRefsStr = notificationData.user_refs || "";
  const batchIndex = notificationData.batch_index || 0;
  const numBatches = notificationData.num_batches || 0;
  const status = notificationData.status || "";

  if (status !== "" && status !== "started") {
    console.log(`Already processed ${snapshot.ref.path}. Skipping...`);
    return;
  }

  if (title === "" || body === "") {
    await snapshot.ref.update({ status: "failed" });
    return;
  }

  const userRefs = userRefsStr === "" ? [] : userRefsStr.trim().split(",");
  var tokens = new Set();
  if (userRefsStr) {
    for (var userRef of userRefs) {
      const userTokens = await firestore
        .doc(userRef)
        .collection(kFcmTokensCollection)
        .get();
      userTokens.docs.forEach((token) => {
        if (typeof token.data().fcm_token !== undefined) {
          tokens.add(token.data().fcm_token);
        }
      });
    }
  } else {
    var userTokensQuery = firestore.collectionGroup(kFcmTokensCollection);
    // Handle batched push notifications by splitting tokens up by document
    // id.
    if (numBatches > 0) {
      userTokensQuery = userTokensQuery
        .orderBy(admin.firestore.FieldPath.documentId())
        .startAt(getDocIdBound(batchIndex, numBatches))
        .endBefore(getDocIdBound(batchIndex + 1, numBatches));
    }
    const userTokens = await userTokensQuery.get();
    userTokens.docs.forEach((token) => {
      const data = token.data();
      const audienceMatches =
        targetAudience === "All" || data.device_type === targetAudience;
      if (audienceMatches && typeof data.fcm_token !== undefined) {
        tokens.add(data.fcm_token);
      }
    });
  }

  const tokensArr = Array.from(tokens);
  var messageBatches = [];
  for (let i = 0; i < tokensArr.length; i += 500) {
    const tokensBatch = tokensArr.slice(i, Math.min(i + 500, tokensArr.length));
    const messages = {
      notification: {
        title,
        body,
        ...(imageUrl && { imageUrl: imageUrl }),
      },
      data: {
        initialPageName,
        parameterData,
      },
      android: {
        notification: {
          ...(sound && { sound: sound }),
        },
      },
      apns: {
        payload: {
          aps: {
            ...(sound && { sound: sound }),
          },
        },
      },
      tokens: tokensBatch,
    };
    messageBatches.push(messages);
  }

  var numSent = 0;
  await Promise.all(
    messageBatches.map(async (messages) => {
      const response = await admin.messaging().sendEachForMulticast(messages);
      numSent += response.successCount;
    }),
  );

  await snapshot.ref.update({ status: "succeeded", num_sent: numSent });
}

function getUserFcmTokensCollection(userDocPath) {
  return firestore.doc(userDocPath).collection(kFcmTokensCollection);
}

function getDocIdBound(index, numBatches) {
  if (index <= 0) {
    return "Users/(";
  }
  if (index >= numBatches) {
    return "Users/}";
  }
  const numUidChars = 62;
  const twoCharOptions = Math.pow(numUidChars, 2);

  var twoCharIdx = (index * twoCharOptions) / numBatches;
  var firstCharIdx = Math.floor(twoCharIdx / numUidChars);
  var secondCharIdx = Math.floor(twoCharIdx % numUidChars);
  const firstChar = getCharForIndex(firstCharIdx);
  const secondChar = getCharForIndex(secondCharIdx);
  return "Users/" + firstChar + secondChar;
}

function getCharForIndex(charIdx) {
  if (charIdx < 10) {
    return String.fromCharCode(charIdx + "0".charCodeAt(0));
  } else if (charIdx < 36) {
    return String.fromCharCode("A".charCodeAt(0) + charIdx - 10);
  } else {
    return String.fromCharCode("a".charCodeAt(0) + charIdx - 36);
  }
}
exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("Users/" + user.uid);
});

// ==================== SUBSCRIPTION EXPIRY CRON TRIGGER ====================
// Runs periodically to expire completed passes (24h, 30d, 90d) and send 24h warnings
exports.checkSubscriptionExpirySchedule = functions.pubsub
  .schedule("every 15 minutes")
  .onRun(async (context) => {
    console.log("⏰ Running Subscription Expiry Check Cron Job...");
    const now = admin.firestore.Timestamp.now();
    const nowDate = now.toDate();
    const in24HoursDate = new Date(nowDate.getTime() + 24 * 60 * 60 * 1000);
    const in24HoursTimestamp = admin.firestore.Timestamp.fromDate(in24HoursDate);

    const usersRef = admin.firestore().collection("Users");

    try {
      // 1. Find all active premium users whose subscription has expired
      const expiredSnapshot = await usersRef
        .where("is_premium", "==", true)
        .where("subscription_expires_at", "<=", now)
        .get();

      console.log(`Found ${expiredSnapshot.size} expired subscriptions.`);

      const batch = admin.firestore().batch();
      for (const doc of expiredSnapshot.docs) {
        const userData = doc.data();
        console.log(`Expiring subscription for user ${doc.id} (Tier: ${userData.subscription_tier})`);

        batch.update(doc.ref, {
          is_premium: false,
          isPremium: false,
          subscription_status: "expired",
          plan_expired_at: now,
          notified_expiring_soon: false,
        });

        // Trigger push notification for expiration
        try {
          await admin.firestore().collection(kPushNotificationsCollection).add({
            notification_title: "⚠️ Your Travia VIP Pass Has Expired",
            notification_text: "Your pass has ended. Tap here to renew your VIP status & direct driver calling!",
            user_refs: `Users/${doc.id}`,
            initial_page_name: "Plans",
            parameter_data: JSON.stringify({ plan_expired: true }),
            status: "",
            created_at: now,
          });
        } catch (e) {
          console.error(`Failed to queue expiration push notification for user ${doc.id}:`, e);
        }
      }

      if (expiredSnapshot.size > 0) {
        await batch.commit();
        console.log("Expired subscriptions successfully updated in batch.");
      }

      // 2. Find subscriptions expiring within the next 24 hours that haven't been warned
      const expiringSoonSnapshot = await usersRef
        .where("is_premium", "==", true)
        .where("subscription_expires_at", ">", now)
        .where("subscription_expires_at", "<=", in24HoursTimestamp)
        .get();

      console.log(`Found ${expiringSoonSnapshot.size} subscriptions expiring within 24 hours.`);

      for (const doc of expiringSoonSnapshot.docs) {
        const userData = doc.data();
        if (userData.notified_expiring_soon === true) continue;

        console.log(`Sending 24h expiry reminder to user ${doc.id}`);
        await doc.ref.update({ notified_expiring_soon: true });

        // Trigger push notification warning
        try {
          await admin.firestore().collection(kPushNotificationsCollection).add({
            notification_title: "⏳ Travia VIP Pass Expiring Soon",
            notification_text: "Your Travia pass expires within 24 hours! Renew today to prevent interruption of your VIP perks.",
            user_refs: `Users/${doc.id}`,
            initial_page_name: "Plans",
            parameter_data: JSON.stringify({ expiring_soon: true }),
            status: "",
            created_at: now,
          });
        } catch (e) {
          console.error(`Failed to queue 24h warning push notification for user ${doc.id}:`, e);
        }
      }

      return null;
    } catch (error) {
      console.error("Error in checkSubscriptionExpirySchedule:", error);
      return null;
    }
  });

// Callable function for client app to instantly check & sync its subscription expiry
exports.checkMySubscriptionExpiry = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be logged in");
  }
  const uid = context.auth.uid;
  const userRef = admin.firestore().collection("Users").doc(uid);
  const userDoc = await userRef.get();

  if (!userDoc.exists) {
    throw new functions.https.HttpsError("not-found", "User not found");
  }

  const userData = userDoc.data();
  const isPremium = userData.is_premium === true || userData.isPremium === true;
  const expiresAt = userData.subscription_expires_at;

  if (isPremium && expiresAt) {
    const now = admin.firestore.Timestamp.now();
    if (expiresAt.toMillis() <= now.toMillis()) {
      await userRef.update({
        is_premium: false,
        isPremium: false,
        subscription_status: "expired",
        plan_expired_at: now,
        notified_expiring_soon: false,
      });
      return { status: "expired", is_premium: false };
    }
    return { status: "active", is_premium: true, expires_at: expiresAt.toDate().toISOString() };
  }

  return { status: "inactive", is_premium: false };
});
