// import 'dart:math';
// import 'dart:convert' show jsonEncode;
// import 'package:flutter/material.dart';
// import 'package:foodlab/main.dart';
// import 'package:foodlab/notifications/notify.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'local_notify.dart';
//
// class TopicSubscriptions {
//   //
//   static const String job = 'Job';
//   static const String offers = 'Offers';
//   static const String requests = 'Requests';
//   static const String announcement = 'Announcement';
//   static const String enquiryEmp = 'EnquiryEmployees';
//   static const String enquiryCus = 'EnquiryCustomers';
//   static const String newsAndEvents = 'NewsAndEvents';
//   static const String feedbackEmp = 'feedbackEmployees';
//   static const String feedbackCus = 'FeedbackCustomers';
//   //
//
//   // ==================== Admin ====================
//   static void adminSubscriptions() async {
//     await FMServices.subscribeToTopic(job);
//     await FMServices.subscribeToTopic(requests);
//     await FMServices.subscribeToTopic(enquiryCus);
//     await FMServices.subscribeToTopic(enquiryEmp);
//     await FMServices.subscribeToTopic(feedbackCus);
//     await FMServices.subscribeToTopic(feedbackEmp);
//     await FMServices.subscribeToTopic(announcement);
//   }
//
//   static void adminUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(job);
//     await FMServices.unSubscribeFromTopic(requests);
//     await FMServices.unSubscribeFromTopic(enquiryCus);
//     await FMServices.unSubscribeFromTopic(enquiryEmp);
//     await FMServices.unSubscribeFromTopic(feedbackCus);
//     await FMServices.unSubscribeFromTopic(feedbackEmp);
//     await FMServices.unSubscribeFromTopic(announcement);
//   }
//   // ==================== Admin ====================
//
//   // ==================== Watcher ====================
//   static void watcherSubscriptions() async {
//     await FMServices.subscribeToTopic(job);
//     await FMServices.subscribeToTopic(requests);
//     await FMServices.subscribeToTopic(enquiryCus);
//     await FMServices.subscribeToTopic(enquiryEmp);
//     await FMServices.subscribeToTopic(feedbackCus);
//     await FMServices.subscribeToTopic(feedbackEmp);
//     await FMServices.subscribeToTopic(announcement);
//   }
//
//   static void watcherUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(job);
//     await FMServices.unSubscribeFromTopic(requests);
//     await FMServices.unSubscribeFromTopic(enquiryCus);
//     await FMServices.unSubscribeFromTopic(enquiryEmp);
//     await FMServices.unSubscribeFromTopic(feedbackCus);
//     await FMServices.unSubscribeFromTopic(feedbackEmp);
//     await FMServices.unSubscribeFromTopic(announcement);
//   }
//   // ==================== Watcher ====================
//
//   // ==================== HR ====================
//   static void hrSubscriptions() async {
//     await FMServices.subscribeToTopic(job);
//     await FMServices.subscribeToTopic(offers);
//     await FMServices.subscribeToTopic(requests);
//     await FMServices.subscribeToTopic(enquiryEmp);
//     await FMServices.subscribeToTopic(feedbackEmp);
//     await FMServices.subscribeToTopic(announcement);
//     await FMServices.subscribeToTopic(newsAndEvents);
//   }
//
//   static void hrUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(job);
//     await FMServices.unSubscribeFromTopic(offers);
//     await FMServices.unSubscribeFromTopic(requests);
//     await FMServices.unSubscribeFromTopic(enquiryEmp);
//     await FMServices.unSubscribeFromTopic(feedbackEmp);
//     await FMServices.unSubscribeFromTopic(announcement);
//     await FMServices.unSubscribeFromTopic(newsAndEvents);
//   }
//   // ==================== HR ====================
//
//   // ==================== Sales ====================
//   static void salesSubscriptions() async {
//     await FMServices.subscribeToTopic(enquiryCus);
//     await FMServices.subscribeToTopic(feedbackCus);
//     await FMServices.subscribeToTopic(announcement);
//     await FMServices.subscribeToTopic(newsAndEvents);
//   }
//
//   static void salesUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(enquiryCus);
//     await FMServices.unSubscribeFromTopic(feedbackCus);
//     await FMServices.unSubscribeFromTopic(announcement);
//     await FMServices.unSubscribeFromTopic(newsAndEvents);
//   }
//   // ==================== Sales ====================
//
//   // ==================== Normal ====================
//   static void normalSubscriptions() async {
//     await FMServices.subscribeToTopic(announcement);
//     await FMServices.subscribeToTopic(newsAndEvents);
//   }
//
//   static void normalUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(announcement);
//     await FMServices.unSubscribeFromTopic(newsAndEvents);
//   }
//   // ==================== Normal ====================
//
//   // ==================== Guest ====================
//   static void guestSubscriptions() async {
//     await FMServices.subscribeToTopic(offers);
//     await FMServices.subscribeToTopic(newsAndEvents);
//   }
//
//   static void guestUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(offers);
//     await FMServices.unSubscribeFromTopic(newsAndEvents);
//   }
//   // ==================== Guest ====================
//
//   // ==================== Customer ====================
//   static void customerSubscriptions() async {
//     await FMServices.subscribeToTopic(offers);
//     await FMServices.subscribeToTopic(newsAndEvents);
//   }
//
//   static void customerUnSubscriptions() async {
//     await FMServices.unSubscribeFromTopic(offers);
//     await FMServices.unSubscribeFromTopic(newsAndEvents);
//   }
// // ==================== Customer ====================
// }
//
// class Params {
//   final String? token;
//   final String? topic;
//   final String body;
//   final String title;
//
//   Params({this.token, this.topic, required this.body, required this.title});
// }
//
// class FMServices {
//   static Future<void> initialize() async {
//     await FirebaseMessaging.instance.requestPermission();
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
//     FirebaseMessaging.onMessage
//         .listen((message) {
//       key.currentState?.push(MaterialPageRoute(builder: (context)=>Notify())) ;
//       LocalNotifyService.display(message);
//       print('the onMessage execute');
//     });
//     FirebaseMessaging.onMessageOpenedApp
//         .listen((message) {
//       print('the onMessageOpenedApp execute');
//       key.currentState?.push(MaterialPageRoute(builder: (context)=>Notify())) ;
//
//       LocalNotifyService.display(message);
//     });
//   }
//
//   static Future<void> _onBackgroundMessage(RemoteMessage message) async =>
//       LocalNotifyService.display(message);
//
//   // ================== Subscribe To Topic ================
//   static Future<void> subscribeToTopic(String topic) async =>
//       await FirebaseMessaging.instance.subscribeToTopic(topic);
//
//   // ================== UnSubscribe From Topic ================
//   static Future<void> unSubscribeFromTopic(String topic) async =>
//       await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
//
//   // ================== Send Notification ================
//   static Future<void> sendNotify(Params params) async {
//     await http.post(
//       Uri.parse(APINotify.baseUrl),
//       headers: APINotify.headers,
//       body: jsonEncode({
//         'priority': 'high',
//         'data': APINotify.data(params.title),
//         'to': params.token ?? '/topics/${params.topic}',
//         'notification': {'title': params.title, 'body': params.body},
//       }),
//     );
//   }
// }
//
// class APINotify {
//   // ==================== Base URL Firebase Cloud Messaging ====================
//   static String baseUrl = 'https://fcm.googleapis.com/fcm/send';
//
//   // =================== Server Key Or Token Cloud Messaging ===================
//   static const String _serverToken =
//       'AAAAI_yRZzE:APA91bFABtpKHjq_W5PjzWur1Q1V8PED1DgJcPEkgVcTSDDWM3BD8U17Hc2nIR_d1OMZameJGbGnP0JOLEpRGA1JZ-pHi_Ts_lSuvyDMrSbfvoMI5ZsPC0hrIIAcRltdgb0sns53mepx';
//
//   // ======================== Header Send Notifications ========================
//   static Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'key=$_serverToken',
//   };
//
//   static Map<String, String> data(String title) {
//     Map<String, String> data = {
//       'id': '${Random().nextInt(1000000000)}',
//       'status': 'done',
//       'message': title,
//       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//     };
//     return data;
//   }
// }
