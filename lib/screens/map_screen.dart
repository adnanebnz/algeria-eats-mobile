import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Future getPermisions() async {
    // var status = await Permission.location.status;
    // if (status.isDenied) {
    //   await Permission.location.request();
    // }
    await Permission.locationWhenInUse.request();
  }

  void initState() {
    getPermisions();
    super.initState();
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
