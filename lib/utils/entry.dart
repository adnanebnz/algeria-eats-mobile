import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    if (box.read('alreadyShown') == true) {
      Future.microtask(() => Get.offAllNamed("/on-board"));
    } else {
      Future.microtask(() => Get.offAllNamed("/intro"));
    }

    return const CircularProgressIndicator();
  }
}
