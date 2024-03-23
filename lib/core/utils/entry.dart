import 'package:algeria_eats/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    if (box.read('alreadyShown') == true) {
      Future.microtask(() => Get.offAllNamed("/on-board"));
    } else {
      Future.microtask(() => Get.offAllNamed("/intro"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loader(
          size: 50,
        ),
      ),
    );
  }
}
