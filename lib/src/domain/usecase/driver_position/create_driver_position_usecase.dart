import 'package:hey_taxi_app/src/domain/models/driver_position.dart';
import 'package:hey_taxi_app/src/domain/repository/driver_position_repository.dart';

class CreateDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  CreateDriverPositionUseCase( this.driverPositionRepository );

  run(DriverPosition driverPosition) => driverPositionRepository.create(driverPosition);

 
}