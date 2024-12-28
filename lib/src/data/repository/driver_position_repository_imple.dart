


import 'package:hey_taxi_app/src/data/dataSource/remote/service/driver_position_service.dart';
import 'package:hey_taxi_app/src/domain/models/driver_position.dart';
import 'package:hey_taxi_app/src/domain/repository/driver_position_repository.dart';
import 'package:hey_taxi_app/src/domain/utils/resource.dart';

class DriverPositionRepositoryImple extends DriverPositionRepository {

  DriverPositionService driverPositionService;

  DriverPositionRepositoryImple( this.driverPositionService );


  @override
  Future<Resource<bool>> create(DriverPosition driverPosition) {
    return driverPositionService.create(driverPosition);
  }

  @override
  Future<Resource<bool>> delete(int idDriver) {
    return driverPositionService.delete(idDriver);
    
  }
  
  @override
  Future<Resource<DriverPosition>> getDriverPosition(int idDriver) {
   return driverPositionService.getDriverPosition(idDriver);
  }

}