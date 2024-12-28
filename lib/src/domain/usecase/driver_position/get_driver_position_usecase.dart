


import 'package:hey_taxi_app/src/domain/repository/index.dart';

class GetDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  GetDriverPositionUseCase( this.driverPositionRepository );

  run(int idDriver) => driverPositionRepository.getDriverPosition(idDriver);

 
}