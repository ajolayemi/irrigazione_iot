import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'location_service.g.dart';

class LocationService {
  /// Default location coordinates
  /// Set to Rome, Italy
  static const LatLng defaultLocation = LatLng(41.9028, 12.4964);

  /// Accesses the user's current location
  /// Returns a [Position] object
  Future<Position?> getCurrentLocation() async {
    try {
      final permission = await isLocationServiceEnabled();
      if (!permission) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (error) {
      throw Exception(
        'An error occurred while trying to get the user\'s location',
      );
    }
  }

  /// Checks if the location service is returned and if
  /// user has granted location permissions
  Future<bool> isLocationServiceEnabled() async {
    final bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.always || LocationPermission.whileInUse:
        return true;
      case LocationPermission.denied:
        return await requestLocationPermission();
      case LocationPermission.deniedForever:
        return false;
      case LocationPermission.unableToDetermine:
        return false;
    }
  }

  /// Requests user's permission to access location
  Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}

@Riverpod(keepAlive: true)
LocationService locationService(LocationServiceRef ref) {
  return LocationService();
}
