import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class FCMService extends GetxService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
// TODO FIX SERVICE
  @override
  void onInit() {
    super.onInit();
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'high_importance_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        defaultColor: Colors.orange,
        ledColor: Colors.orange,
      ),
    ]);
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      requestIOSPermissions();
    }
    setupInteractions();
  }

  void setupInteractions() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        AwesomeNotifications()
            .createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'high_importance_channel',
            title: notification.title ?? '',
            body: notification.body ?? '',
          ),
        )
            .catchError((e) {
          if (kDebugMode) {
            printInfo(info: 'Failed to create notification: $e');
          }
        });
      }
    });
  }

  void requestIOSPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        printInfo(info: 'User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        printInfo(info: 'User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        printInfo(info: 'User declined or has not accepted permission');
      }
    }
  }
}
