// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:notification/main.dart';
// import 'package:notification/users/home/onSelectNot.dart';
//
// class LocalNotifyService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const String icon = '@mipmap/ic_launcher';
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings(icon),
//       iOS: DarwinInitializationSettings(),
//     );
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse response) {
//           key.currentState?.push(MaterialPageRoute(builder: (context) => OnSelectNotification()));
//     },
//     onDidReceiveBackgroundNotificationResponse: (NotificationResponse response) {
//       key.currentState?.push(MaterialPageRoute(builder: (context) => OnSelectNotification()));
//       },
//     );
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       const iOS = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//       const android = AndroidNotificationDetails(
//         "ChanelOne",
//         "MyChanel",
//         priority: Priority.high,
//         importance: Importance.max,
//         channelShowBadge: true,
//         // sound: RawResourceAndroidNotificationSound("ss"),
//         enableVibration: true,
//         //  playSound: true
//       );
//       const notifyDetails = NotificationDetails(iOS: iOS, android: android);
//       await _flutterLocalNotificationsPlugin.show(
//         message.notification.hashCode,
//         message.notification!.title,
//         message.notification!.body,
//         notifyDetails,
//       );
//     } on Exception catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
