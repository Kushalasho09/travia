const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin
admin.initializeApp();

// ==================== CHAT NOTIFICATION TRIGGER ====================
exports.sendChatNotificationTrigger = functions.firestore
  .document("Chats/{chatId}")
  .onWrite(async (change, context) => {
    console.log("=".repeat(60));
    console.log("🚀 CHAT NOTIFICATION FUNCTION TRIGGERED");
    console.log("=".repeat(60));

    console.log("📌 Chat ID:", context.params.chatId);
    console.log("📌 Timestamp:", new Date().toISOString());

    // Ignore deletes
    if (!change.after.exists) {
      console.log("📌 Document deleted, skipping");
      return null;
    }

    const beforeData = change.before.data();
    const afterData = change.after.data();

    console.log("📊 BEFORE DATA:", beforeData ? JSON.stringify(beforeData) : "No before data");
    console.log("📊 AFTER DATA:", JSON.stringify(afterData, null, 2));

    // Check if this is a real message update (not just seenBy update)
    const isNewMessage = !beforeData ||
                        beforeData.lastMessage !== afterData.lastMessage ||
                        beforeData.lastMessageTime !== afterData.lastMessageTime;

    if (!isNewMessage) {
      console.log("📌 Not a new message (same content/time), skipping");
      return null;
    }

    const {
      userIDs,
      lastMessage,
      lastMessageSenderId,
      lastMessagesSeenBy,
    } = afterData;

    // ==================== VALIDATION ====================
    console.log("\n🔍 VALIDATING DATA:");
    console.log("   lastMessage:", lastMessage || "❌ MISSING");
    console.log("   userIDs:", userIDs ? `${userIDs.length} users` : "❌ MISSING");
    console.log("   lastMessageSenderId:", lastMessageSenderId || "❌ MISSING");

    if (!lastMessage) {
      console.log("❌ FAILED: No lastMessage field");
      return null;
    }

    if (!userIDs || !Array.isArray(userIDs) || userIDs.length < 2) {
      console.log("❌ FAILED: Invalid userIDs field");
      return null;
    }

    if (!lastMessageSenderId) {
      console.log("❌ FAILED: lastMessageSenderId is missing!");
      console.log("   Flutter must include 'lastMessageSenderId' in chat update");
      return null;
    }

    // ==================== FIND RECIPIENT ====================
    console.log("\n👥 FINDING RECIPIENT:");
    console.log("   Sender ID:", lastMessageSenderId);

    let recipientId = null;
    let recipientIndex = -1;

    for (let i = 0; i < userIDs.length; i++) {
      const userRef = userIDs[i];
      const userId = userRef.id;
      console.log(`   [${i}] User: ${userId} (${userRef.path})`);

      if (userId !== lastMessageSenderId) {
        recipientId = userId;
        recipientIndex = i;
        break;
      }
    }

    if (!recipientId) {
      console.log("❌ FAILED: Could not find recipient");
      console.log("   All user IDs:", userIDs.map(u => u.id));
      return null;
    }

    console.log("✅ RECIPIENT FOUND:", recipientId);
    console.log("   Recipient index:", recipientIndex);

    // ==================== CHECK IF SEEN ====================
    if (lastMessagesSeenBy && Array.isArray(lastMessagesSeenBy)) {
      const hasSeen = lastMessagesSeenBy.some(ref => ref.id === recipientId);
      if (hasSeen) {
        console.log("📌 Recipient has already seen this message, still sending the notification");
       // return null;
      }
    }

    // ==================== GET RECIPIENT TOKEN ====================
    console.log("\n🔑 GETTING RECIPIENT FCM TOKEN:");

    try {
      const recipientDoc = await admin.firestore()
        .collection("Users")
        .doc(recipientId)
        .get();

      if (!recipientDoc.exists) {
        console.log("❌ FAILED: Recipient document not found in Users collection");
        return null;
      }

      const recipientData = recipientDoc.data();
      console.log("   Recipient document exists ✅");
      console.log("   Available fields:", Object.keys(recipientData));

      // Check for FCM token (support both field names)
      let fcmToken = recipientData.fcmToken || recipientData.fcmTokens;

      // If fcmTokens is an array, take first token
      if (Array.isArray(fcmToken) && fcmToken.length > 0) {
        fcmToken = fcmToken[0];
      }

      if (!fcmToken || typeof fcmToken !== 'string') {
        console.log("❌ FAILED: No valid FCM token found");
        console.log("   fcmToken field value:", fcmToken);
        console.log("   Token type:", typeof fcmToken);
        console.log("\n💡 SOLUTION:");
        console.log("   1. Make sure recipient has FCM token saved");
        console.log("   2. Field should be 'fcmToken' (string) in Users collection");
        console.log("   3. Or 'fcmTokens' (array) with at least one token");
        return null;
      }

      console.log("✅ FCM TOKEN FOUND!");
      console.log("   Token (first 40 chars):", fcmToken.substring(0, 40) + "...");
      console.log("   Token length:", fcmToken.length);

      // ==================== GET SENDER INFO ====================
      console.log("\n👤 GETTING SENDER INFO:");
      let senderName = "Someone";

      try {
        const senderDoc = await admin.firestore()
          .collection("Users")
          .doc(lastMessageSenderId)
          .get();

        if (senderDoc.exists) {
          const senderData = senderDoc.data();
          senderName = senderData.name ||
                      senderData.username ||
                      senderData.displayName ||
                      senderData.email ||
                      "Someone";
          console.log("✅ Sender name found:", senderName);
        } else {
          console.log("⚠️ Sender document not found, using default name");
        }
      } catch (senderError) {
        console.log("⚠️ Could not get sender info:", senderError.message);
      }

      // ==================== PREPARE NOTIFICATION ====================
      console.log("\n📝 PREPARING NOTIFICATION:");
      const notificationBody = lastMessage.length > 100
        ? lastMessage.substring(0, 100) + "..."
        : lastMessage;

      console.log("   Title:", senderName);
      console.log("   Body:", notificationBody);
      console.log("   Chat ID:", context.params.chatId);

      const message = {
        token: fcmToken,
        notification: {
title: `💬 New message from ${senderName}`,
          body: notificationBody,
        },
        data: {
          chatId: context.params.chatId,
          senderId: lastMessageSenderId,
          type: "chat_message",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
          message: lastMessage.substring(0, 200),
        },
        android: {
          priority: "high",
          notification: {
            sound: "default",
            channelId: "chat_messages",
            tag: context.params.chatId,
          },
        },
        apns: {
          payload: {
            aps: {
              alert: {
                title: senderName,
                body: notificationBody,
              },
              sound: "default",
              badge: 1,
              'mutable-content': 1,
            },
          },
          headers: {
            'apns-priority': '10',
          },
        },
        webpush: {
          headers: {
            Urgency: "high",
          },
        },
      };

      // ==================== SEND NOTIFICATION ====================
      console.log("\n📤 SENDING NOTIFICATION...");

      try {
        const response = await admin.messaging().send(message);
        console.log("=".repeat(60));
        console.log("✅ NOTIFICATION SENT SUCCESSFULLY! 🎉");
        console.log("=".repeat(60));
        console.log("📱 Message ID:", response);
        console.log("👤 From:", senderName);
        console.log("👥 To:", recipientId);
        console.log("💬 Message:", lastMessage.substring(0, 50) + "...");
        console.log("⏰ Time:", new Date().toISOString());
        console.log("=".repeat(60));

        return null;
      } catch (sendError) {
        console.log("❌ FAILED TO SEND NOTIFICATION:");
        console.log("   Error:", sendError.message);
        console.log("   Error code:", sendError.code);
        console.log("   Full error:", sendError);
        return null;
      }

    } catch (error) {
      console.log("=".repeat(60));
      console.log("❌ CRITICAL ERROR IN FUNCTION:");
      console.log("=".repeat(60));
      console.log("Error:", error.message);
      console.log("Stack:", error.stack);
      console.log("=".repeat(60));
      return null;
    }
  });

// ==================== CHAT & BOOKING NOTIFICATION CALLABLE ====================
exports.sendChatNotification = functions.https.onCall(async (data, context) => {
  console.log("🚀 HTTPS CALLABLE sendChatNotification CALLED");
  console.log("Data:", JSON.stringify(data));

  const { token, senderName, message: msgText, chatId } = data;

  if (!token) {
    console.log("❌ No token provided");
    throw new functions.https.HttpsError(
      "invalid-argument",
      "FCM token is required ('token')"
    );
  }

  const title = chatId ? `💬 New message from ${senderName}` : senderName;
  const body = msgText;

  const message = {
    token: token,
    notification: {
      title: title || "New Notification",
      body: body || "",
    },
    data: {
      chatId: chatId || "",
      senderName: senderName || "",
      message: body || "",
      type: chatId ? "chat_message" : "booking_notification",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
    android: {
      priority: "high",
      notification: {
        sound: "default",
        channelId: "chat_messages",
      },
    },
    apns: {
      payload: {
        aps: {
          alert: {
            title: title || "New Notification",
            body: body || "",
          },
          sound: "default",
          badge: 1,
          'mutable-content': 1,
        },
      },
      headers: {
        'apns-priority': '10',
      },
    },
  };

  console.log("📤 Sending push notification to token:", token.substring(0, 30) + "...");
  try {
    const response = await admin.messaging().send(message);
    console.log("✅ NOTIFICATION SENT SUCCESSFULLY:", response);
    return {
      success: true,
      messageId: response,
    };
  } catch (error) {
    console.error("❌ FAILED TO SEND NOTIFICATION:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to send push notification: " + error.message
    );
  }
});

// ==================== ADD FCM TOKEN ====================
exports.addFcmToken = functions.https.onCall(async (data, context) => {
  console.log("📱 ADD FCM TOKEN CALLED");

  if (!context.auth) {
    console.log("❌ User not authenticated");
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be logged in"
    );
  }

  const { token } = data;
  const userId = context.auth.uid;

  console.log("👤 User ID:", userId);
  console.log("🔑 Token (first 30):", token ? token.substring(0, 30) + "..." : "NO TOKEN");

  if (!token) {
    console.log("❌ No token provided");
    throw new functions.https.HttpsError(
      "invalid-argument",
      "FCM token is required"
    );
  }

  try {
    console.log("💾 Saving token to Firestore...");
    await admin.firestore()
      .collection("Users")
      .doc(userId)
      .set({
        fcmToken: token,
        fcmTokenUpdated: admin.firestore.FieldValue.serverTimestamp(),
        lastActive: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });

    console.log("✅ Token saved successfully");
    return {
      success: true,
      message: "FCM token saved",
      userId: userId,
      tokenSaved: true
    };
  } catch (error) {
    console.log("❌ Error saving token:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to save FCM token",
      error.message
    );
  }
});

// ==================== TEST FUNCTIONS ====================
exports.testFunction = functions.https.onRequest((req, res) => {
  console.log("🧪 TEST FUNCTION CALLED");
  res.json({
    success: true,
    message: "🔥 Firebase Functions are WORKING! 🚀",
    timestamp: new Date().toISOString(),
    project: "traviaapp",
    status: "operational",
    functions: ["sendChatNotification", "addFcmToken", "testFunction"]
  });
});

exports.testNotification = functions.https.onCall(async (data, context) => {
  console.log("🔔 TEST NOTIFICATION CALLED");

  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Login required");
  }

  const userId = context.auth.uid;

  try {
    // Get user's FCM token
    const userDoc = await admin.firestore()
      .collection("Users")
      .doc(userId)
      .get();

    if (!userDoc.exists) {
      throw new functions.https.HttpsError("not-found", "User not found");
    }

    const userData = userDoc.data();
    const fcmToken = userData.fcmToken;

    if (!fcmToken) {
      throw new functions.https.HttpsError("failed-precondition", "No FCM token found");
    }

    // Send test notification
    const message = {
      token: fcmToken,
      notification: {
        title: "✅ Test Notification",
        body: "Firebase Functions are working correctly! 🎉",
      },
      data: {
        type: "test",
        timestamp: new Date().toISOString(),
      },
    };

    await admin.messaging().send(message);

    return {
      success: true,
      message: "Test notification sent!",
      userId: userId,
      timestamp: new Date().toISOString()
    };

  } catch (error) {
    console.error("Test notification error:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});

// ==================== DEBUG USER TOKENS ====================
exports.debugUserTokens = functions.https.onCall(async (data, context) => {
  console.log("🐛 DEBUG USER TOKENS CALLED");

  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Login required");
  }

  try {
    const usersSnapshot = await admin.firestore()
      .collection("Users")
      .limit(10)
      .get();

    const users = [];
    usersSnapshot.forEach(doc => {
      const data = doc.data();
      users.push({
        id: doc.id,
        name: data.name || data.username || "Unknown",
        hasFcmToken: !!data.fcmToken,
        fcmToken: data.fcmToken ? data.fcmToken.substring(0, 20) + "..." : "None",
        hasFcmTokens: Array.isArray(data.fcmTokens) && data.fcmTokens.length > 0,
        fcmTokensCount: Array.isArray(data.fcmTokens) ? data.fcmTokens.length : 0,
      });
    });

    return {
      success: true,
      totalUsers: users.length,
      users: users,
      timestamp: new Date().toISOString()
    };

  } catch (error) {
    console.error("Debug error:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
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

        // If user has FCM token, send push notification
        if (userData.fcmToken) {
          try {
            await admin.messaging().send({
              token: userData.fcmToken,
              notification: {
                title: "⚠️ Your Travia VIP Pass Has Expired",
                body: "Your pass has ended. Tap to renew your VIP status & direct driver calling!",
              },
              data: {
                type: "subscription_expired",
                page: "Plans",
              },
            });
          } catch (err) {
            console.error(`Error sending push to ${doc.id}:`, err);
          }
        }
      }

      if (expiredSnapshot.size > 0) {
        await batch.commit();
        console.log("Expired subscriptions successfully updated in batch.");
      }

      // 2. Find subscriptions expiring within next 24 hours that haven't been warned
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

        if (userData.fcmToken) {
          try {
            await admin.messaging().send({
              token: userData.fcmToken,
              notification: {
                title: "⏳ Travia VIP Pass Expiring Soon",
                body: "Your pass expires within 24 hours! Renew today to prevent interruption of your VIP perks.",
              },
              data: {
                type: "subscription_expiring_soon",
                page: "Plans",
              },
            });
          } catch (err) {
            console.error(`Error sending 24h warning to ${doc.id}:`, err);
          }
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