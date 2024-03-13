import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCMService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    AwesomeNotifications().requestPermissionToSendNotifications();
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'high_importance_channel',
            channelName: 'High Importance Notifications',
            channelDescription:
                'This is a channel for high importance notifications',
            importance: NotificationImportance.High,
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white),
      ],
    );
    initializeRemoteNotifications(debug: true);
  }

  static Future<void> initializeRemoteNotifications(
      {required bool debug}) async {
    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: mySilentDataHandle,
        onFcmTokenHandle: myFcmTokenHandle,
        onNativeTokenHandle: myNativeTokenHandle,
        licenseKeys: null,
        debug: debug);
  }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    if (kDebugMode) {
      print('"SilentData": ${silentData.toString()}');
    }

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'high_importance_channel',
        title: silentData.data?['title'],
        body: silentData.data?['body'],
      ),
    );
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }

  // Request FCM token to Firebase
  Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken =
            await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (e) {
        printError(info: '$e');
      }
    } else {
      printError(info: 'Firebase is not available on this project');
    }
    return firebaseAppToken;
  }
}
