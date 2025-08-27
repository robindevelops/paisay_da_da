import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/app.dart';
import 'package:paisay_da_da/core/notifications/notification.dart';
import 'package:paisay_da_da/core/themes/log.dart';
import 'package:paisay_da_da/setup.dart';

/// Background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Log.d('📥 Foreground message received: ${message.toMap()}');

  NotificationService.showLocalNotification(
    message,
    'payload_from_background',
  );
}

// /// Handle background tap on local notification
// @pragma('vm:entry-point')
// void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
//   if (response.payload != null) {}
// }

void setupFirebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Extract notification title and body
    String title = message.notification?.title ?? 'No Title';
    String body = message.notification?.body ?? 'No Body';

    // Log the message
    print('📥 Foreground message received: $title - $body');
    print('📦 Data payload: ${message.data}');

    // Show local notification
    NotificationService.showLocalNotification(
      message,
      'payload_from_foreground',
    );
  });
}

Future<void> main() async {
  await setup();
  setupFirebaseMessagingListener();
  runApp(const MyApp());
}
