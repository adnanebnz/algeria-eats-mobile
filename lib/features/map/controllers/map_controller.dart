import 'dart:async';

import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/services/geolocation_service.dart';
import 'package:algeria_eats/features/artisans/controllers/artisan_controller.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/artisans/views/artisan_profile_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  RxSet<Marker> markers = <Marker>{}.obs;
  final locationData = Get.find<GeoLocationService>().locationData;

  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();

  late CameraPosition initialCameraPosition;

  final dio = DioInstance.getDio();

  void initialize() {
    if (locationData != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(locationData?['latitude'], locationData?['longitude']),
        zoom: 10.0,
      );
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: const MarkerId('currentLocation'),
        position: LatLng(locationData?['latitude'], locationData?['longitude']),
      ));
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 10,
      );
    }
  }

  Future setMarkersOfArtisans() async {
    try {
      final artisanController = Get.find<ArtisanController>();
      for (Artisan artisan in artisanController.artisans) {
        final cords = await getLatLongFromAddress(
            "${artisan.user.adresse} ${artisan.user.wilaya}");
        printInfo(info: cords.toString());
        markers.add(Marker(
          markerId: MarkerId(artisan.user.id.toString()),
          position: LatLng(cords[0].latitude, cords[0].longitude),
          infoWindow: InfoWindow(
            title: artisan.user.nom,
            snippet: artisan.user.adresse,
            onTap: () {
              Get.to(() => ArtisanProfileScreen(artisan: artisan));
            },
          ),
        ));
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<List<Location>> getLatLongFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return locations;
    } catch (e) {
      printError(info: e.toString());
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
    setMarkersOfArtisans();
  }

  @override
  void onClose() {
    markers.clear();
    super.onClose();
  }
}
