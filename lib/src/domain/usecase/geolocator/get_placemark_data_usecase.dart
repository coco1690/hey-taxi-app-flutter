
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class GetPlacemarkDataUsecase {

  GeolocatorRepository geolocatorRepository;

  GetPlacemarkDataUsecase(this.geolocatorRepository);

  run(CameraPosition cameraPosition )  => geolocatorRepository.getPlacemarkData( cameraPosition );
}