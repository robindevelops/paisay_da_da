import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/locator/locator.dart';
import 'package:paisay_da_da/core/notifications/notification.dart';
import 'package:paisay_da_da/core/socket.io.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/firebase_options.dart';
import 'package:paisay_da_da/main.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDatabase.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initializePushNotifications();

  await ServiceLocator.setup();

  final socketService = SocketService();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  socketService.connect();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();

  print('FCM Token: $fcmToken');

  HiveDatabase.storeValue("fcmToken", fcmToken);

  print('FCM Token Stored in hive: $fcmToken');
}
