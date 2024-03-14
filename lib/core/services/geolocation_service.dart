import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocationService extends GetxService {
  final box = GetStorage();

  Map<String, dynamic>? get locationData => box.read('location');

  @override
  void onInit() {
    super.onInit();
    _requestPermissionsAndSaveLocation();
    //print locationData
    printInfo(info: 'Location Data: ${locationData ?? 'No location data'}');
  }

  Future<void> _requestPermissionsAndSaveLocation() async {
    try {
      Map<String, dynamic> locationData = await determinePosition();
      box.write('location', locationData);
    } catch (e) {
      printError(info: 'Failed to get location: $e');
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    return {
      'longitude': position.longitude,
      'latitude': position.latitude,
      'city': place.locality,
      'country': place.country,
    };
  }
}
