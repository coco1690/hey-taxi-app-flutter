import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class FindMyPositionUseCase {
  
  GeolocatorRepository geolocatorRepository;

  FindMyPositionUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.findMyPosition();
  
}