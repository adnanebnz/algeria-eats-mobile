import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FCMService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    initializeRemoteNotifications(debug: true);
  }

  static Future<void> initializeRemoteNotifications(
      {required bool debug}) async {
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

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      if (kDebugMode) {
        print("bg");
      }
    } else {
      if (kDebugMode) {
        print("FOREGROUND");
      }
    }

    if (kDebugMode) {
      print("starting long task");
    }
    await Future.delayed(const Duration(seconds: 4));
    final re = await DioInstance.getDio().get("http://google.com");
    if (kDebugMode) {
      print(re.data);
      print("long task done");
    }
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
}
