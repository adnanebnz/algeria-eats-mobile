import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService extends GetxService {
  Rx<bool> isConnected = true.obs;

  late StreamSubscription<InternetStatus> subscription;

  @override
  void onReady() {
    super.onReady();
    subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          isConnected.value = true;
          break;
        case InternetStatus.disconnected:
          isConnected.value = false;
          break;
      }
    });

    isConnected.listen((value) {
      if (!value) {
        // ShowSnackBar.show("Auccune connexion a Internet", 'error');
      }
    });
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
