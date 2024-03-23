import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GeoLocationService extends GetxService {
  final GetStorage box = GetStorage();
  StreamSubscription<Position>? _positionStreamSubscription;

  Map<String, dynamic>? get locationData => box.read('location');

  @override
  void onInit() {
    super.onInit();
    _checkLocationServicesAndPermissions();
  }

  Future<void> _checkLocationServicesAndPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _showLocationDialog(
          'Please enable location services and grant location permissions to use this app.');
    } else {
      saveLocationData();
    }
  }

  Future<void> saveLocationData() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    // Save the location data
    Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'country': place.country,
      'city': place.locality,
    };
    box.write('location', locationData);

    printInfo(info: 'LAST SAVED LOCATION: ${locationData.toString()}');
  }

  Future<void> _showLocationDialog(String message) async {
    await Get.dialog(
      AlertDialog(
        title: const Text('Location Services'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Geolocator.requestPermission();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void startListeningLocationChanges() {
    _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 10,
    )).listen((Position position) async {
      // Get the place from the coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      // Save the location data
      Map<String, dynamic> locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'country': place.country,
        'city': place.locality,
      };
      box.write('location', locationData);

      printInfo(info: 'LAST SAVED LOCATION: ${locationData.toString()}');
    });
  }

  void stopListeningLocationChanges() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
  }

  @override
  void onClose() {
    stopListeningLocationChanges();
    super.onClose();
  }
}
