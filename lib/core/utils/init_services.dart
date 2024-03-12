import 'dart:async';

import 'package:algeria_eats/core/utils/error_snackbar.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InitServices extends GetxService {
  Rx<ConnectivityResult> connectivityStatus = (ConnectivityResult.none).obs;

  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void onInit() {
    super.onInit();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectivityStatus.value = result;
    });

    ever(connectivityStatus, (ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ErrorSnackBar.show("Pas de Connection Internet", 'error');
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }
}
