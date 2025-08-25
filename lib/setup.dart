import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/locator/locator.dart';
import 'package:paisay_da_da/core/socket.io.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/firebase_options.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final socketService = SocketService();
  socketService.connect();

  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print('FCM Token: $fcmToken');

  // await NotificationService.initializePushNotifications();
  await HiveDatabase.init();
  ServiceLocator.setup();
}
