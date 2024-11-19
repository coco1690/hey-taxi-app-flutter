import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class GetMarkerUseCase {
  
  GeolocatorRepository geolocatorRepository;

  GetMarkerUseCase(this.geolocatorRepository);

  run(String markerId, double lat, double lng, BitmapDescriptor imageMarker, String title, String content) => geolocatorRepository.getMarker(markerId, lat, lng, imageMarker, title, content);
  
}