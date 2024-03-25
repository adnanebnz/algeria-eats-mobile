// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'package:algeria_eats/core/services/geolocation_service.dart';
import 'package:algeria_eats/features/map/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: mapController.initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) async {
                    mapController.completer.complete(controller);
                    String mapStyle = await rootBundle
                        .loadString('assets/json/standart.json');
                    controller.setMapStyle(mapStyle);
                  },
                  markers: mapController.markers.value,
                )),
            Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      //fly to the current location
                      final GoogleMapController controller =
                          await mapController.completer.future;
                      final locationData =
                          Get.find<GeoLocationService>().locationData;
                      if (locationData != null) {
                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(
                                locationData['latitude'],
                                locationData['longitude'],
                              ),
                              zoom: 13.0,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.location_searching_rounded,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
