


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class GetPolylineUseCase {
  GeolocatorRepository geolocatorRepository;

  GetPolylineUseCase(this.geolocatorRepository);

  run(LatLng pickUpPLatLng, LatLng destinationLatLng) => geolocatorRepository.getPolyline(pickUpPLatLng, destinationLatLng);
}