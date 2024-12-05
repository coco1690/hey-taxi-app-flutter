import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class CreateMarkerUseCase {
  
  GeolocatorRepository geolocatorRepository;

  CreateMarkerUseCase(this.geolocatorRepository);

  run(String path, double width, double height) => geolocatorRepository.createMarkerFromAsset(path, width, height);
  
}