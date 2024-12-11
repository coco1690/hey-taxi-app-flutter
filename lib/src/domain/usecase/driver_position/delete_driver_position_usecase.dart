
import 'package:hey_taxi_app/src/domain/repository/driver_position_repository.dart';

class DeleteDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  DeleteDriverPositionUseCase( this.driverPositionRepository );

  run(int idDriver) => driverPositionRepository.delete(idDriver);

 
}