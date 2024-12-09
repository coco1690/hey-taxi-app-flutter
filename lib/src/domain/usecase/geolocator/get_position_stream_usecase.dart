



import 'package:hey_taxi_app/src/domain/repository/gelocator_repository.dart';

class GetPositionStreamUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPositionStreamUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.getPositionStream();
}