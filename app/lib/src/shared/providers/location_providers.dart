// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/shared/services/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_providers.g.dart';

@riverpod
FutureOr<LatLng> userLocationCoordinates(UserLocationCoordinatesRef ref) async {
  final service = ref.watch(locationServiceProvider);
  final location = await service.getCurrentLocation();
  return location != null
      ? LatLng(location.latitude, location.longitude)
      : LocationService.defaultLocation;
}
