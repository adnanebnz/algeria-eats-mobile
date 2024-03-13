import 'dart:async';

import 'package:algeria_eats/core/utils/error_snackbar.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService extends GetxService {
  Rx<bool> isConnected = false.obs;

  late StreamSubscription<InternetStatus> subscription;

  @override
  void onInit() {
    super.onInit();
    subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          isConnected.value = true;
          break;
        case InternetStatus.disconnected:
          isConnected.value = false;
          ErrorSnackBar.show("Pas de connexion a Internet!", 'error');
          break;
      }
    });
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
